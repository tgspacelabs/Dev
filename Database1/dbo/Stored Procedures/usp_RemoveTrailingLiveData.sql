
CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveData]
AS
BEGIN
    SET NOCOUNT ON;

    --CREATE TABLE [#CutoffRows]
    --    (
    --     [LiveDataId] UNIQUEIDENTIFIER NOT NULL
    --    );

    --INSERT  INTO [#CutoffRows]
    --SELECT
    --    [Id]
    --FROM
    --    [dbo].[LiveData]
    --    INNER JOIN (SELECT
    --                    [LD].[TopicInstanceId],
    --                    [LD].[FeedTypeId],
    --                    DATEADD(SECOND, -150, MAX([LD].[TimestampUTC])) AS [LatestUTC]
    --                FROM
    --                    [dbo].[LiveData] AS [LD]
    --                GROUP BY
    --                    [TopicInstanceId],
    --                    [FeedTypeId]
    --               ) AS [TopicFeedLatestToKeep] ON [LiveData].[TopicInstanceId] = [TopicFeedLatestToKeep].[TopicInstanceId]
    --                                               AND [LiveData].[FeedTypeId] = [TopicFeedLatestToKeep].[FeedTypeId]
    --WHERE
    --    [TimestampUTC] < [TopicFeedLatestToKeep].[LatestUTC];

    --DELETE FROM
    --    [dbo].[LiveData]
    --WHERE
    --    [Id] IN (SELECT
    --                [LiveDataId]
    --             FROM
    --                [#CutoffRows]);


    DELETE [ld]
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
                   ) AS [TopicFeedLatestToKeep] ON [ld].[TopicInstanceId] = [TopicFeedLatestToKeep].[TopicInstanceId]
                                                   AND [ld].[FeedTypeId] = [TopicFeedLatestToKeep].[FeedTypeId]
    WHERE
        [ld].[TimestampUTC] < [TopicFeedLatestToKeep].[LatestUTC];


    --;WITH [CutoffRows] AS 
    --(
    --SELECT
    --    [Id] AS [LiveDataId]
    --FROM
    --    [dbo].[LiveData]
    --    INNER JOIN (SELECT
    --                    [LD].[TopicInstanceId],
    --                    [LD].[FeedTypeId],
    --                    DATEADD(SECOND, -150, MAX([LD].[TimestampUTC])) AS [LatestUTC]
    --                FROM
    --                    [dbo].[LiveData] AS [LD]
    --                GROUP BY
    --                    [TopicInstanceId],
    --                    [FeedTypeId]
    --               ) AS [TopicFeedLatestToKeep] ON [LiveData].[TopicInstanceId] = [TopicFeedLatestToKeep].[TopicInstanceId]
    --                                               AND [LiveData].[FeedTypeId] = [TopicFeedLatestToKeep].[FeedTypeId]
    --WHERE
    --    [TimestampUTC] < [TopicFeedLatestToKeep].[LatestUTC]
    --)
    --DELETE FROM
    --    [dbo].[LiveData]
    --WHERE
    --    [Id] IN (SELECT
    --                [LiveDataId]
    --             FROM
    --                [CutoffRows]);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_RemoveTrailingLiveData';

