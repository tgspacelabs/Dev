

CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveData]
AS
BEGIN

	SET NOCOUNT ON

	CREATE TABLE #CutoffRows([LiveDataId] UNIQUEIDENTIFIER NOT NULL)

	INSERT INTO #CutoffRows
		SELECT [LiveData].[Id]
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

	DELETE FROM [dbo].LiveData
	WHERE [Id] IN (SELECT [LiveDataId] FROM #CutoffRows)

END

