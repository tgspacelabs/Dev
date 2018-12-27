

CREATE VIEW [dbo].[v_VitalsData]
AS
SELECT
      [VitalsData].[Id]
      ,[VitalsData].[SetId]
      ,[VitalsData].[Name]
      ,[VitalsData].[Value] AS [ResultValue]
      ,[TopicSessions].TopicTypeId
      ,[TopicSessions].[Id] AS [TopicSessionId]
      ,[VitalsData].[TimestampUTC] AS [DateTimeStampUTC]
      ,[v_PatientTopicSessions].[PatientId] AS [PatientId]
      ,GdsCodeMap.[GdsCode] as [GdsCode]
      ,[VitalsData].[FeedTypeId] AS [TypeId]
  FROM 

    [dbo].[VitalsData] 
    INNER JOIN GdsCodeMap ON 
        GdsCodeMap.FeedTypeId = [VitalsData].[FeedTypeId] AND GdsCodeMap.[Name] = [VitalsData].[Name]
    INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id]=[VitalsData].[TopicSessionId]
    INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId]=[TopicSessions].[Id]
