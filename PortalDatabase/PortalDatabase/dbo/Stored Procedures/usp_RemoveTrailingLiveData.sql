CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveData]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ChunkSize INT = 1500;
    DECLARE @DateString VARCHAR(30) = CAST(SYSDATETIME() AS VARCHAR(30));
    DECLARE @RowCount INT = @ChunkSize;

    WHILE (@RowCount > 0)
    BEGIN
        DELETE TOP (@ChunkSize)
            [ld]
        FROM
            [dbo].[LiveData] AS [ld]
            INNER JOIN (SELECT
                            [ld].[TopicInstanceId],
                            [ld].[FeedTypeId],
                            DATEADD(SECOND, -150, MAX([ld].[TimestampUTC])) AS [LatestUTC]
                        FROM
                            [dbo].[LiveData] AS [ld]
                        GROUP BY
                            [ld].[TopicInstanceId],
                            [ld].[FeedTypeId]
                       ) AS [TopicFeedLatestToKeep]
                ON [ld].[TopicInstanceId] = [TopicFeedLatestToKeep].[TopicInstanceId]
                   AND [ld].[FeedTypeId] = [TopicFeedLatestToKeep].[FeedTypeId]
        WHERE
            [ld].[TimestampUTC] < [TopicFeedLatestToKeep].[LatestUTC];

        SET @RowCount = @@ROWCOUNT;
        SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
        RAISERROR (N'%s - %d rows deleted', 10, 1, @DateString, @RowCount) WITH NOWAIT;
    END;

    -- Delete any other live data older than 10 days
    DECLARE @PurgeDate DATETIME2 = DATEADD(DAY, -10, SYSUTCDATETIME());
    SET @RowCount = @ChunkSize;

    WHILE (@RowCount > 0)
    BEGIN
        DELETE TOP (@ChunkSize) -- TOP is not allowed in an UPDATE or DELETE statement against a partitioned view.
            [ld]
        FROM
            [dbo].[LiveData] AS [ld]
        WHERE
            [ld].[TimestampUTC] < @PurgeDate;

        SET @RowCount = @@ROWCOUNT;
        SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
        RAISERROR (N'%s - %d rows deleted', 10, 1, @DateString, @RowCount) WITH NOWAIT;
    END;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Remove the live data attached to a topic instance that is over 2.5 minutes old.  Then delete any live data that is more than 10 days old.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_RemoveTrailingLiveData';

