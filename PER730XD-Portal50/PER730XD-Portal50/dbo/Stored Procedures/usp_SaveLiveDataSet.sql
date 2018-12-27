--USE [portal]
--GO

--/****** Object:  StoredProcedure [dbo].[usp_SaveLiveDataSet]    Script Date: 5/18/2015 11:29:24 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE PROCEDURE [dbo].[usp_SaveLiveDataSet]
CREATE PROCEDURE [dbo].[usp_SaveLiveDataSet]
    (@liveData [dbo].[NameValueDataSetType] READONLY)
AS
BEGIN
    SET NOCOUNT ON;

    --INSERT INTO LiveData([Id], [TopicInstanceId], [FeedTypeId], [Name], [Value], [TimestampUTC], [Mod4])
    --SELECT [LD].[Id], [TopicInstanceId],[FeedTypeId],[Name],[Value],[TimestampUTC], DATEPART(minute, [TimestampUTC])%4 FROM @liveData AS [LD] 
    --INNER JOIN [dbo].[TopicSessions] 
    --    ON [TopicSessions].[Id] = [LD].[TopicSessionId]

    INSERT INTO [dbo].[LiveData] ([Id], [TopicInstanceId], [FeedTypeId], [Name], [Value], [TimestampUTC])
    SELECT [LD].[Id], [TopicInstanceId],[FeedTypeId],[Name],[Value],[TimestampUTC]
    FROM @liveData AS [LD] 
        INNER JOIN [dbo].[TopicSessions] 
        ON [TopicSessions].[Id] = [LD].[TopicSessionId];
END
