
/*This view is used to get the latest channel types from waveforms and topics from non waveform*/
CREATE VIEW [dbo].[v_ActivePatientChannels]
AS
SELECT 
TypeId, 
TopicTypeId,
PatientId, 
Active = CASE WHEN EndTimeUTC IS NULL THEN 1 ELSE NULL END
FROM
    (SELECT DISTINCT topictypeid, 
    [v_PatientTopicSessions].[PatientId], NULL AS TypeId, 
    EndTimeUTC
    FROM TopicSessions 
    INNER JOIN [dbo].[v_PatientTopicSessions] ON [TopicSessions].[Id]=[v_PatientTopicSessions].[TopicSessionId]
    INNER JOIN TopicTypes 
    ON TopicTypes.Id = TopicSessions.TopicTypeId WHERE TopicTypeId IN (SELECT TopicTypeId FROM [dbo].[v_LegacyChannelTypes] WHERE TypeId IS NULL)
    ) AS NonWaveformChannelTypes
  
UNION ALL
(

SELECT 
TypeId, 
TopicTypeId, 
[v_PatientTopicSessions].[PatientId],   
Active = CASE WHEN TopicSessions.EndTimeUTC IS NULL THEN 1 ELSE NULL END
from WaveformLiveData  AS WAVEFRM
INNER JOIN TopicSessions 
    ON TopicSessions.TopicInstanceId = WAVEFRM.TopicInstanceId
INNER JOIN [dbo].[v_PatientTopicSessions] ON [TopicSessions].[Id]=[v_PatientTopicSessions].[TopicSessionId]
GROUP BY TypeId,TopicTypeId,PatientId,TopicSessions.EndTimeUTC

UNION        
    
SELECT  
DISTINCT TopicSessions.TopicTypeId as TypeId, 
TopicSessions.TopicTypeId, 
[v_PatientTopicSessions].[PatientId],  
Active = CASE WHEN EndTimeUTC IS NULL THEN 1 ELSE NULL END
from vitalsdata
INNER JOIN TopicSessions
    ON TopicSessions.Id = vitalsdata.TopicSessionId
INNER JOIN [dbo].[v_PatientTopicSessions] ON [TopicSessions].[Id]=[v_PatientTopicSessions].[TopicSessionId]
WHERE TopicSessions.TopicTypeId NOT IN (SELECT DISTINCT TopicTypeId from WaveformData INNER JOIN TopicSessions ON TopicSessions.Id = WaveformData.TopicSessionId)
AND TopicTypeId IN (SELECT TopicTypeId FROM [dbo].[v_LegacyChannelTypes] WHERE TypeId IS NOT NULL)
)
