
CREATE PROCEDURE [dbo].[GetPatientChannelList] (@patientId UNIQUEIDENTIFIER) 
AS
BEGIN
  SELECT 
    channel_type_id AS PATIENT_CHANNEL_ID,
    channel_type_id AS CHANNEL_TYPE_ID
 FROM 
   dbo.int_patient_channel
 WHERE 
   patient_id = @patientId and
   active_sw = 1
   
UNION ALL

SELECT DISTINCT TypeId as PATIENT_CHANNEL_ID, TypeId as CHANNEL_TYPE_ID
FROM 
(
	select TypeId from WaveformLiveData
	inner join TopicSessions on TopicSessions.TopicInstanceId = WaveformLiveData.TopicInstanceId
	where TopicSessions.Id in (select TopicSessionId from v_PatientTopicSessions where PatientId = @patientId)
	and TopicSessions.EndTimeUTC IS NULL

	UNION ALL

	select TopicSessions.TopicTypeId from TopicSessions -- add non-waveform types
	INNER JOIN TopicFeedTypes on TopicFeedTypes.FeedTypeId = TopicSessions.TopicTypeId
	where TopicSessions.Id in (select TopicSessionId from v_PatientTopicSessions where PatientId = @patientId)
	and TopicSessions.EndTimeUTC IS NULL
) TypeIds


END
