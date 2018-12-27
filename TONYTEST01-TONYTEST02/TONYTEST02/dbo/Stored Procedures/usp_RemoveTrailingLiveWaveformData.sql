
CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveWaveformData]
AS
BEGIN

	SET NOCOUNT ON

	CREATE TABLE #CutoffRows([LiveDataId] UNIQUEIDENTIFIER NOT NULL)

	INSERT INTO #CutoffRows
		SELECT [WaveformLiveData].[Id]
			FROM [dbo].[WaveformLiveData]
			INNER JOIN
			(
				SELECT [TopicInstanceId], [TypeId], MAX(EndTimeUTC) AS [LatestUTC]
					FROM [dbo].[WaveformLiveData] AS [LD]
					GROUP BY [TopicInstanceId], [TypeId]
			) AS [TopicFeedLatestToKeep]
			ON [WaveformLiveData].[TopicInstanceId] = [TopicFeedLatestToKeep].[TopicInstanceId]
			WHERE [WaveformLiveData].[StartTimeUTC] < [TopicFeedLatestToKeep].[LatestUTC]

	DELETE FROM [dbo].[WaveformLiveData]
	WHERE [Id] IN (SELECT [LiveDataId] FROM #CutoffRows)

END


