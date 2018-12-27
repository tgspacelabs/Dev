
--USE [portal]
--GO

--/****** Object:  StoredProcedure [dbo].[usp_SaveLiveDataSet]    Script Date: 5/18/2015 11:29:24 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--ALTER PROCEDURE [dbo].[usp_SaveLiveDataSet]
CREATE PROCEDURE [dbo].[usp_SaveLiveDataSet]
    (
     @LiveData [dbo].[NameValueDataSetType] READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

    --INSERT INTO LiveData([Id], [TopicInstanceId], [FeedTypeId], [Name], [Value], [TimestampUTC], [Mod4])
    --SELECT [LD].[Id], [TopicInstanceId],[FeedTypeId],[Name],[Value],[TimestampUTC], DATEPART(minute, [TimestampUTC])%4 FROM @liveData AS [LD] 
    --INNER JOIN [dbo].[TopicSessions] 
    --	ON [TopicSessions].[Id] = [LD].[TopicSessionId]

    INSERT  INTO [dbo].[LiveData]
            ([Id],
             [TopicInstanceId],
             [FeedTypeId],
             [Name],
             [Value],
             [TimestampUTC]
            )
    SELECT
        [LD].[Id],
        [TopicInstanceId],
        [LD].[FeedTypeId],
        [LD].[Name],
        [LD].[Value],
        [LD].[TimeStampUTC]
    FROM
        @LiveData AS [LD]
        INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [LD].[TopicSessionId];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_SaveLiveDataSet';

