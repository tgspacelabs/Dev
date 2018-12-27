
CREATE VIEW [dbo].[v_StatusData]
AS
SELECT
      StatusData.[Id]
      ,StatusData.[SetId]
      ,StatusData.[Name]
      ,StatusData.[Value] AS [ResultValue]
      ,[TopicSessions].TopicTypeId
      ,[TopicSessions].[Id] AS [TopicSessionId]
      ,[StatusDataSets].[TimestampUTC] AS [DateTimeStampUTC]
      ,[dbo].[fnUtcDateTimeToLocalTime]([StatusDataSets].[TimestampUTC]) AS [DateTimeStamp]
      ,[v_PatientTopicSessions].[PatientId] AS [PatientId]
      ,[dbo].[fnDateTimeToFileTime]([StatusDataSets].[TimestampUTC]) as [FileDateTimeStamp]
      ,[GdsCode] = 
              CASE StatusData.[Name]
                WHEN 'lead1Index' THEN '2.1.2.0'
                WHEN 'lead2Index' THEN '2.2.2.0'
              ELSE StatusData.[Name]
             END
    ,[StatusDataSets].[FeedTypeId] AS [FeedTypeId]
  FROM 
    [dbo].StatusData
    INNER JOIN [dbo].[StatusDataSets] 
        ON StatusData.[SetId] = [StatusDataSets].[Id]
    INNER JOIN [dbo].[TopicSessions] 
        ON [TopicSessions].[Id] = [StatusDataSets].[TopicSessionId]
    INNER JOIN [dbo].[v_PatientTopicSessions] 
        ON [v_PatientTopicSessions].[TopicSessionId] = [TopicSessions].[Id]
