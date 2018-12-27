
CREATE PROCEDURE [dbo].[usp_SaveLiveDataSet]
	(@liveData [dbo].[NameValueDataSetType] READONLY)
AS
BEGIN

	SET NOCOUNT ON
	INSERT INTO LiveData([Id], [TopicInstanceId], [FeedTypeId], [Name], [Value], [TimestampUTC], [Mod4])
	SELECT [LD].[Id], [TopicInstanceId],[FeedTypeId],[Name],[Value],[TimestampUTC], DATEPART(minute, [TimestampUTC])%4 FROM @liveData AS [LD] 
	INNER JOIN [dbo].[TopicSessions] 
		ON [TopicSessions].[Id] = [LD].[TopicSessionId]

END

