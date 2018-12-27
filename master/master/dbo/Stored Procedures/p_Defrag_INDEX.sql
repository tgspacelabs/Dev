
--@@BEGIN@@
CREATE PROC [dbo].[p_Defrag_INDEX]
(
    @dbName sysname = 'portal', 
    @statsMode varchar(8) = 'SAMPLED', 
    @defragType varchar(10) = 'REORGANIZE', 
    @minFragPercent int = 50, 
    @maxFragPercent int = 100, 
    @minRowCount int = 0
)
AS
BEGIN

  SET NOCOUNT ON

  IF @statsMode NOT IN ('LIMITED', 'SAMPLED', 'DETAILED')
  BEGIN
      RAISERROR('@statsMode must be LIMITED, SAMPLED or DETAILED', 16, 1)
      RETURN
  END

  IF @defragType NOT IN ('REORGANIZE', 'REBUILD')
  BEGIN
      RAISERROR('@defragType must be REORGANIZE or REBUILD', 16, 1)
      RETURN
  END

  DECLARE 
      @i int, @objectId int, @objectName sysname, @indexId int, @indexName sysname, 
      @schemaName sysname, @partitionNumber int, @partitionCount int,
      @sql nvarchar(4000), @edition int, @parmDef nvarchar(500), @allocUnitType nvarchar(60),
      @indexType nvarchar(60), @online bit, @disabled bit, @dataType nvarchar(128),
      @charMaxLen int

  SELECT @edition = CONVERT(int, SERVERPROPERTY('EngineEdition'))

  SELECT 
      IDENTITY(int, 1, 1) AS FragIndexId, 
      [object_id] AS ObjectId, 
      index_id AS IndexId, 
      avg_fragmentation_in_percent AS FragPercent, 
      record_count AS RecordCount, 
      partition_number AS PartitionNumber,
      index_type_desc AS IndexType,
      alloc_unit_type_desc AS AllocUnitType,
      0 AS Online
  INTO #FragIndex
  FROM sys.dm_db_index_physical_stats (DB_ID(@dbName), NULL, NULL, NULL, @statsMode)
  WHERE 
      avg_fragmentation_in_percent > @minFragPercent AND 
      avg_fragmentation_in_percent < @maxFragPercent AND 
      index_id > 0
  ORDER BY ObjectId

  -- LIMITED does not include data for record_count
  IF @statsMode IN ('SAMPLED', 'DETAILED')
      DELETE FROM #FragIndex
      WHERE RecordCount < @minRowCount

  -- Developer and Enterprise have the ONLINE = ON option for REBUILD
  -- Indexes, including indexes on global temp tables, can be rebuilt online with the following exceptions:
  -- Disabled indexes, XML indexes, Indexes on local temp tables, Partitioned indexes,
  -- Clustered indexes if the underlying table contains LOB data types,
  -- Nonclustered indexes that are defined with LOB data type columns
  IF @defragType = 'REBUILD' AND @edition = 3
  BEGIN
      UPDATE #FragIndex
      SET Online = 1

      UPDATE #FragIndex
      SET Online = 
              CASE
                  WHEN IndexType = 'XML INDEX' THEN 0
                  WHEN IndexType = 'NONCLUSTERED INDEX' AND AllocUnitType = 'LOB_DATA' THEN 0
                  ELSE 1
              END

      -- we can't determine if the indexes are disabled or partitioned yet,
      -- so we'll need to figure that out during the loop
      -- we also have to figure out if the table contains lob_data when
      -- a clustered index exists during the loop
  END

  SELECT @i = MIN(FragIndexId) 
  FROM #FragIndex

  SELECT 
      @objectId = ObjectId, 
      @indexId = IndexId, 
      @partitionNumber = PartitionNumber,
      @indexType = IndexType,
      @online = Online
  FROM #FragIndex
  WHERE FragIndexId = @i

  WHILE @@ROWCOUNT <> 0
  BEGIN
      SET @sql = '
          SELECT @objectName = o.[name], @schemaName = s.[name]
          FROM ' + @dbName + '.sys.objects o
          JOIN ' + @dbName + '.sys.schemas s 
          ON s.schema_id = o.schema_id
          WHERE o.[object_id] = @objectId'

      SET @parmDef = N'@objectId int, @objectName sysname OUTPUT, @schemaName sysname OUTPUT'

      EXEC sp_executesql 
          @sql, @parmDef, @objectId = @objectId, 
          @objectName = @objectName OUTPUT, @schemaName = @schemaName OUTPUT

      IF @indexType = 'CLUSTERED INDEX'
      BEGIN
          -- can't use online option if index is clustered and table contains following 
          -- data types: text, ntext, image, varchar(max), nvarchar(max), varbinary(max) or xml
          -- CHARACTER_MAXIMUM_LENGTH column will equal -1 for max size or xml
          SET @sql = '
              SELECT @online = 0
              FROM ' + @dbName + '.INFORMATION_SCHEMA.COLUMNS c
              WHERE    TABLE_NAME = @objectName AND
                      (DATA_TYPE IN (''text'', ''ntext'', ''image'') OR 
                      CHARACTER_MAXIMUM_LENGTH = -1)'

          SET @parmDef = N'@objectName sysname, @online bit OUTPUT'

          EXEC sp_executesql 
              @sql, @parmDef, @objectName = @objectName, @online = @online OUTPUT
      END

      SET @sql = '
          SELECT @indexName = [name], @disabled = is_disabled
          FROM ' + @dbName + '.sys.indexes
          WHERE [object_id] = @objectId AND index_id = @indexId'

      SET @parmDef = N'
          @objectId int, @indexId int, @indexName sysname OUTPUT, @disabled bit OUTPUT'

      EXEC sp_executesql 
          @sql, @parmDef, @objectId = @objectId, @indexId = @indexId, 
          @indexName = @indexName OUTPUT, @disabled = @disabled OUTPUT

      SET @sql = '
          SELECT @partitionCount = COUNT(*)
          FROM ' + @dbName + '.sys.partitions
          WHERE [object_id] = @objectId AND index_id = @indexId'

      SET @parmDef = N'@objectId int, @indexId int, @partitionCount int OUTPUT'

      EXEC sp_executesql 
          @sql, @parmDef, @objectId = @objectId, @indexId = @indexId, 
          @partitionCount = @partitionCount OUTPUT

      SET @sql = 'ALTER INDEX [' + @indexName + '] ON [' + @dbName + '].[' + 
          @schemaName + '].[' + @objectName + '] ' + @defragType

      IF    @online = 1 AND @disabled = 0 AND @partitionCount = 1
          SET @sql = @sql + ' WITH (ONLINE = ON)'

      IF @partitionCount > 1 AND @disabled = 0 AND @indexType <> 'XML INDEX'
          SET @sql = @sql + ' PARTITION = ' + CAST(@partitionNumber AS varchar(10))

      EXEC (@SQL)

      SELECT @i = MIN(FragIndexId) 
      FROM #FragIndex
      WHERE FragIndexId > @i

      SELECT 
          @objectId = ObjectId, 
          @indexId = IndexId, 
          @partitionNumber = PartitionNumber,
          @indexType = IndexType,
          @online = Online
      FROM #FragIndex
      WHERE FragIndexId = @i
  END

  DROP TABLE #FragIndex
 END
--@@END@@

