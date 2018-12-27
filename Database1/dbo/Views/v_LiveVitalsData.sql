
CREATE VIEW [dbo].[v_LiveVitalsData]
AS
SELECT
livedata.Name
,livedata.Value AS ResultValue
,TopicSessions.TopicTypeId
,TopicSessions.id AS TopicSessionId
,[v_PatientTopicSessions].[PatientId] AS PatientId
,TopicSessions.TopicInstanceId 
,[GdsCode] = 
	  CASE LiveData.[Name]
		WHEN 'T1Value' THEN '4.6.' + cast((1 + cast([dbo].[fnZeroIfBigger]([vdt1].[Value], 32767) as int)) as NVARCHAR(15))+'.0'
		WHEN 'T2Value' THEN '4.7.' + cast((1 + cast([dbo].[fnZeroIfBigger]([vdt2].[Value], 32767) as int)) as NVARCHAR(15))+'.0'
		WHEN 'lead1Index' THEN '2.1.2.0'
		WHEN 'lead2Index' THEN '2.2.2.0'
		ELSE [GdsMetaData].[Value]
	  END
,LiveData.TimestampUTC AS [DateTimeStampUTC]
,[dbo].[fnUtcDateTimeToLocalTime](LiveData.[TimestampUTC]) AS [DateTimeStamp]
,[dbo].[fnDateTimeToFileTime](LiveData.[TimestampUTC]) as [FileDateTimeStamp]
,LiveData.[FeedTypeId]
FROM LiveData
INNER JOIN [dbo].[TopicSessions] 
	ON [TopicSessions].TopicInstanceId = LiveData.TopicInstanceId
	AND [TopicSessions].EndTimeUTC IS NULL
INNER JOIN [dbo].[v_PatientTopicSessions]
	ON [v_PatientTopicSessions].[TopicSessionId]=[TopicSessions].[Id]
LEFT OUTER JOIN [dbo].[v_MetaData] AS [GdsMetaData] 
	 ON [GdsMetaData].[TypeId] = LiveData.[FeedTypeId] 
	 AND [GdsMetaData].[EntityMemberName] = LiveData.[Name] 
	 AND [GdsMetaData].[Name]='GdsCode'
LEFT OUTER JOIN [dbo].LiveData AS vdt1 
	ON [LiveData].id=vdt1.id
	AND [vdt1].[Name]='T1Location'
LEFT JOIN [dbo].LiveData AS vdt2 
	ON [LiveData].id=vdt2.id
	AND [vdt2].[Name]='T2Location'


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_LiveVitalsData';

