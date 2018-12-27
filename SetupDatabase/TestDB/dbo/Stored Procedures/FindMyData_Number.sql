
CREATE PROCEDURE [FindMyData_Number]
    @DataToFind NVARCHAR(4000),
    @ExactMatch BIT = 0
AS
SET NOCOUNT ON;
DECLARE @Temp TABLE
    (
     [RowId] INT IDENTITY(1, 1),
     [SchemaName] sysname,
     [TableName] sysname,
     [ColumnName] sysname,
     [DataType] VARCHAR(100),
     [DataFound] BIT
    );
 
DECLARE @IsNumber BIT;
DECLARE @ISDATE BIT;
 
IF ISNUMERIC(CONVERT(VARCHAR(20), @DataToFind)) = 1
    SET @IsNumber = 1;
ELSE
    SET @IsNumber = 0;
 
INSERT  INTO @Temp
        ([TableName],
         [SchemaName],
         [ColumnName],
         [DataType])
SELECT
    [C].[TABLE_NAME],
    [C].[TABLE_SCHEMA],
    [C].[COLUMN_NAME],
    [C].[DATA_TYPE]
FROM
    [INFORMATION_SCHEMA].[COLUMNS] AS [C]
    INNER JOIN [INFORMATION_SCHEMA].[TABLES] AS [T]
        ON [C].[TABLE_NAME] = [T].[TABLE_NAME]
           AND [C].[TABLE_SCHEMA] = [T].[TABLE_SCHEMA]
WHERE
    [T].[TABLE_TYPE] = 'Base Table'
    AND [C].[DATA_TYPE] IN ('float', 'real', 'decimal', 'money', 'smallmoney', 'bigint', 'int', 'smallint', 'tinyint', 'bit');
 
 
DECLARE @i INT;
DECLARE @MAX INT;
DECLARE @TableName sysname;
DECLARE @ColumnName sysname;
DECLARE @SQL NVARCHAR(4000);
DECLARE @PARAMETERS NVARCHAR(4000);
DECLARE @DataExists BIT;
DECLARE @SQLTemplate NVARCHAR(4000);
 
SELECT
    @SQLTemplate = CASE WHEN @ExactMatch = 1 THEN 'If Exists(Select *
                                           From   ReplaceTableName
                                           Where  Convert(VarChar(40), [ReplaceColumnName])
                                                        = ''' + @DataToFind + '''
                                           )
                                      Set @DataExists = 1
                                  Else
                                      Set @DataExists = 0'
                        ELSE 'If Exists(Select *
                                           From   ReplaceTableName
                                           Where  Convert(VarChar(40), [ReplaceColumnName])
                                                        Like ''%' + @DataToFind + '%''
                                           )
                                      Set @DataExists = 1
                                  Else
                                      Set @DataExists = 0'
                   END,
    @PARAMETERS = '@DataExists Bit OUTPUT',
    @i = 1;
 
SELECT
    @i = 1,
    @MAX = MAX([RowId])
FROM
    @Temp;
 
WHILE @i <= @MAX
BEGIN
    SELECT
        @SQL = REPLACE(REPLACE(@SQLTemplate, 'ReplaceTableName', QUOTENAME([SchemaName]) + '.' + QUOTENAME([TableName])), 'ReplaceColumnName', [ColumnName])
    FROM
        @Temp
    WHERE
        [RowId] = @i;
 
 
    PRINT @SQL;
    EXEC [sys].[sp_executesql]
        @SQL,
        @PARAMETERS,
        @DataExists = @DataExists OUTPUT;
 
    IF @DataExists = 1
        UPDATE
            @Temp
        SET
            [DataFound] = 1
        WHERE
            [RowId] = @i;
 
    SET @i = @i + 1;
END;
 
SELECT
    [SchemaName],
    [TableName],
    [ColumnName]
FROM
    @Temp
WHERE
    [DataFound] = 1;