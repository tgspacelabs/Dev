

CREATE VIEW [dbo].[LiveData]
	WITH SCHEMABINDING
AS
	SELECT [Id], [TopicInstanceId], [FeedTypeId], [Name], [Value], [TimestampUTC], [Mod4]
		FROM [dbo].[LiveData1]
UNION ALL
	SELECT [Id], [TopicInstanceId], [FeedTypeId], [Name], [Value], [TimestampUTC], [Mod4]
		FROM [dbo].[LiveData2]
UNION ALL
	SELECT [Id], [TopicInstanceId], [FeedTypeId], [Name], [Value], [TimestampUTC], [Mod4]
		FROM [dbo].[LiveData3]
UNION ALL
	SELECT [Id], [TopicInstanceId], [FeedTypeId], [Name], [Value], [TimestampUTC], [Mod4]
		FROM [dbo].[LiveData4]
