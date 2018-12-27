CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveWaveformData]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ChunkSize INT = 1500;
    DECLARE @DateString VARCHAR(30) = CAST(SYSUTCDATETIME() AS VARCHAR(30));
    DECLARE @RowCount INT = @ChunkSize;

    WHILE (@RowCount > 0)
    BEGIN
        DELETE TOP (@ChunkSize)
            [wld]
        FROM
            [dbo].[WaveformLiveData] AS [wld]
            INNER JOIN [dbo].[WaveformLiveData] AS [wld1]
                ON [wld].[Id] = [wld1].[Id]
            INNER JOIN (SELECT
                            [wld2].[TopicInstanceId],
                            MAX([wld2].[EndTimeUTC]) AS [LatestUTC]
                        FROM
                            [dbo].[WaveformLiveData] AS [wld2]
                        GROUP BY
                            [wld2].[TopicInstanceId]
                       ) AS [TopicFeedLatestToKeep]
                ON [wld1].[TopicInstanceId] = [TopicFeedLatestToKeep].[TopicInstanceId]
        WHERE
            [wld].[StartTimeUTC] < [TopicFeedLatestToKeep].[LatestUTC];

        SET @RowCount = @@ROWCOUNT;
        SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
        RAISERROR (N'%s - %d rows deleted', 10, 1, @DateString, @RowCount) WITH NOWAIT;
    END;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Remove the waveform live data where start times are less than the latest end times per topic instance ID.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_RemoveTrailingLiveWaveformData';

