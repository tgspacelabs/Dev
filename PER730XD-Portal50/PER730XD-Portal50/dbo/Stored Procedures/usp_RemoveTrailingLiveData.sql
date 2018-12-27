CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveData]
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #CutoffRows([Sequence] BIGINT NOT NULL);
--TRUNCATE TABLE #CutoffRows;

    INSERT INTO #CutoffRows
    SELECT DISTINCT [LiveData].[Sequence]
    FROM [dbo].[LiveData]
        INNER JOIN
        (
            SELECT [TopicInstanceId], [FeedTypeId], DATEADD(second, -150, MAX([TimestampUTC])) AS [LatestUTC]
            FROM [dbo].[LiveData] AS [LD]
            GROUP BY [TopicInstanceId], [FeedTypeId]
        ) AS [TopicFeedLatestToKeep]
            ON [LiveData].[TopicInstanceId] = [TopicFeedLatestToKeep].[TopicInstanceId]
                AND [LiveData].[FeedTypeId] = [TopicFeedLatestToKeep].[FeedTypeId]
    WHERE [LiveData].[TimestampUTC] < [TopicFeedLatestToKeep].[LatestUTC]
    --OPTION (MAXDOP 1);

--DROP INDEX [#CutoffRows_Sequence] ON #CutoffRows;

CREATE CLUSTERED INDEX [#CutoffRows_Sequence] ON #CutoffRows ([Sequence]);

--SELECT COUNT(*) FROM #CutoffRows;

--SELECT COUNT(*) 
--FROM [dbo].LiveData
--WHERE [Sequence] IN (SELECT [Sequence] FROM #CutoffRows)

--SELECT COUNT(*) 
--FROM [dbo].LiveData AS ld
--    INNER JOIN #CutoffRows AS cr 
--        ON ld.[Sequence] = cr.[Sequence]

--DECLARE @DateString VARCHAR(30) = CAST(SYSUTCDATETIME() AS VARCHAR(30));
    DECLARE @Junk INT = 1;
    WHILE (@Junk > 0)
    BEGIN
        DELETE TOP (25000) 
        FROM [dbo].LiveData
        WHERE [Sequence] IN (SELECT [Sequence] FROM #CutoffRows)
        --OPTION (MAXDOP 1);

        SET @Junk = @@ROWCOUNT;
--SET @DateString = CAST(SYSUTCDATETIME() AS VARCHAR(30));
--RAISERROR (N'%s - %d rows deleted', 10, 1, @DateString, @Junk) WITH NOWAIT;
    END

    IF OBJECT_ID('tempdb..#CutoffRows') IS NOT NULL
    BEGIN
        DROP TABLE #CutoffRows;
    END
END
