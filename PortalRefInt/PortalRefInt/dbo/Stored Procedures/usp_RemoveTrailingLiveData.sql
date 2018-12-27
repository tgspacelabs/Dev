CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveData]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ChunkSize INT = 1500;
    DECLARE @DateString VARCHAR(30) = CAST(SYSDATETIME() AS VARCHAR(30));
    DECLARE @RowCount BIGINT = @ChunkSize;
    DECLARE @TotalRows BIGINT = 0;
    DECLARE @Message VARCHAR(200) = '';
    DECLARE @Flag BIT = 1;
    DECLARE @ErrorNumber INT = 0;
    DECLARE @Seconds SMALLINT = 150;
    DECLARE @Multiple TINYINT = 100;

    SET @Message = CAST(SYSDATETIME() AS VARCHAR(40)) + ' - Starting LiveData purge...';
    RAISERROR (@Message, 10, 1) WITH NOWAIT;

    SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
    RAISERROR (N'%s - Chunk Size: %d', 10, 1, @DateString, @ChunkSize) WITH NOWAIT;
    
    SELECT
        [TopicInstanceId],
        [FeedTypeId],
        DATEADD(SECOND, -150, MAX([TimestampUTC])) AS [LatestUTC]
    INTO
        [#CutoffRows]
    FROM
        [dbo].[LiveData] AS [ld]
    GROUP BY
        [TopicInstanceId],
        [FeedTypeId];

    WHILE (@Flag = 1)
    BEGIN
        BEGIN TRY
            DELETE TOP (@ChunkSize) [ld]
            FROM
                [dbo].[LiveData] AS [ld] WITH (ROWLOCK) -- Do not allow lock escalations.
                INNER JOIN [#CutoffRows] AS [cr]
                ON [ld].[TopicInstanceId] = [cr].[TopicInstanceId]
                    AND [ld].[FeedTypeId] = [cr].[FeedTypeId]
            WHERE
                [ld].[TimestampUTC] < [cr].[LatestUTC];

            SET @RowCount = @@ROWCOUNT;
            SET @TotalRows += @RowCount;
        END TRY
        BEGIN CATCH
            SET @ErrorNumber = ERROR_NUMBER();
            RAISERROR (N'%s - ERROR: %d - CONTINUING...', 10, 1, @DateString, @ErrorNumber) WITH NOWAIT;

            WAITFOR DELAY '00:00:01';
    
            CONTINUE;
        END CATCH;

        IF (@TotalRows % (@ChunkSize * @Multiple) = 0) -- When Total Rows is a multiple of Chunk Size
        BEGIN
            SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
            RAISERROR (N'%s - Total Rows Deleted: %I64d ...', 10, 1, @DateString, @TotalRows) WITH NOWAIT;
        END;

        IF (@RowCount = 0)
            SET @Flag = 0;
    END;

    -- Delete any other live data older than 10 days
    DECLARE @PurgeDate DATETIME2 = DATEADD(DAY, -10, SYSUTCDATETIME());
    SET @RowCount = @ChunkSize;
    SET @Flag = 1;

    WHILE (@Flag = 1)
    BEGIN
        BEGIN TRY
            DELETE TOP (@ChunkSize) -- TOP is not allowed in an UPDATE or DELETE statement against a partitioned view.
                [ld]
            FROM
                [dbo].[LiveData] AS [ld] WITH (ROWLOCK) -- Do not allow lock escalations.
            WHERE
                [ld].[TimestampUTC] < @PurgeDate;

            SET @RowCount = @@ROWCOUNT;
            SET @TotalRows += @RowCount;

        END TRY
        BEGIN CATCH
            SET @ErrorNumber = ERROR_NUMBER();
            RAISERROR (N'%s - ERROR: %d - CONTINUING...', 10, 1, @DateString, @ErrorNumber) WITH NOWAIT;

            WAITFOR DELAY '00:00:01';
    
            CONTINUE;
        END CATCH;

        SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
        RAISERROR (N'%s - Total Rows Deleted: %I64d ...', 10, 1, @DateString, @TotalRows) WITH NOWAIT;

        IF (@RowCount = 0)
            SET @Flag = 0;
    END;

    SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
    RAISERROR (N'%s - Total Rows Deleted: %I64d', 10, 1, @DateString, @TotalRows) WITH NOWAIT;

    SET @Message = CAST(SYSDATETIME() AS VARCHAR(40)) + ' - Ending LiveData purge...';
    RAISERROR (@Message, 10, 1) WITH NOWAIT;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Remove the live data attached to a topic instance that is over 2.5 minutes old.  Then delete any live data that is more than 10 days old.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_RemoveTrailingLiveData';

