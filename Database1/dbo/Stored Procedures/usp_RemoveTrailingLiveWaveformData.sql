

CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveWaveformData]
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE [#CutoffRows]
        (
         [LiveDataId] UNIQUEIDENTIFIER NOT NULL
        );

    INSERT  INTO [#CutoffRows]
    SELECT
        [Id]
    FROM
        [dbo].[WaveformLiveData]
        INNER JOIN (SELECT
                        [LD].[TopicInstanceId],
                        [LD].[TypeId],
                        MAX([LD].[EndTimeUTC]) AS [LatestUTC]
                    FROM
                        [dbo].[WaveformLiveData] AS [LD]
                    GROUP BY
                        [TopicInstanceId],
                        [TypeId]
                   ) AS [TopicFeedLatestToKeep] ON [WaveformLiveData].[TopicInstanceId] = [TopicFeedLatestToKeep].[TopicInstanceId]
    WHERE
        [StartTimeUTC] < [TopicFeedLatestToKeep].[LatestUTC];

    DELETE FROM
        [dbo].[WaveformLiveData]
    WHERE
        [Id] IN (SELECT
                    [LiveDataId]
                 FROM
                    [#CutoffRows]);

END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_RemoveTrailingLiveWaveformData';

