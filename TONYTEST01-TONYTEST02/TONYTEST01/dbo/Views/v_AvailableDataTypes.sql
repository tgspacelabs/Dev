
CREATE VIEW [dbo].[v_AvailableDataTypes]
AS
SELECT 
TypeId, 
TopicTypeId,
DeviceSessionId,
PatientId, 
Active = CASE WHEN EndTimeUTC IS NULL THEN 1 ELSE NULL END
FROM
	(SELECT DISTINCT topictypeid, 
	DeviceSessionId, PatientId, NULL AS TypeId, 
	EndTimeUTC
	FROM TopicSessions
	INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId]=[TopicSessions].[Id]
	INNER JOIN TopicTypes 
	ON TopicTypes.Id = TopicSessions.TopicTypeId WHERE TopicTypeId IN (SELECT TopicTypeId FROM [dbo].[v_LegacyChannelTypes] WHERE TypeId IS NULL)
	) AS NonWaveformChannelTypes
  
UNION ALL

(
SELECT 
DISTINCT TypeId, 
TopicTypeId, 
DeviceSessionId,
PatientId,
Active = CASE WHEN TopicSessions.EndTimeUTC IS NULL THEN 1 ELSE NULL END
from WaveformData 
INNER JOIN TopicSessions 
	ON TopicSessions.Id = WaveformData.TopicSessionId
INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId]=[TopicSessions].[Id]

UNION ALL
	
SELECT  
DISTINCT TopicSessions.TopicTypeId as TypeId, 
TopicSessions.TopicTypeId, 
DeviceSessionId,  
PatientId,
Active = CASE WHEN EndTimeUTC IS NULL THEN 1 ELSE NULL END
from vitalsdata
INNER JOIN TopicSessions
	ON TopicSessions.Id = vitalsdata.TopicSessionId
INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId]=[TopicSessions].[Id]
WHERE TopicSessions.TopicTypeId NOT IN (SELECT DISTINCT TopicTypeId from WaveformData INNER JOIN TopicSessions ON TopicSessions.Id = WaveformData.TopicSessionId)
AND TopicTypeId IN (SELECT TopicTypeId FROM [dbo].[v_LegacyChannelTypes] WHERE TypeId IS NOT NULL)
)
