

CREATE PROCEDURE [dbo].[GetPatientChannelTimes] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN
  (
  SELECT 
    int_waveform.patient_id,
     MIN(int_waveform.start_ft) AS MIN_START_FT,
     MAX(int_waveform.end_ft) AS MAX_END_FT,
     int_channel_type.channel_code AS CHANNEL_CODE,
	 NULL AS LABEL,
     int_channel_type.priority,
     int_channel_type.channel_type_id AS CHANNEL_TYPE_ID,
     int_channel_type.freq AS SAMPLE_RATE
  FROM 
    dbo.int_waveform
  INNER JOIN 
    dbo.int_patient_channel ON int_waveform.patient_channel_id = int_patient_channel.patient_channel_id
  INNER JOIN 
    dbo.int_channel_type ON int_patient_channel.channel_type_id = int_channel_type.channel_type_id
  GROUP BY 
    int_waveform.patient_id,
    int_channel_type.channel_code,
    int_channel_type.label,
    int_channel_type.priority,
    int_channel_type.channel_type_id,
    int_channel_type.freq
  HAVING 
    (int_waveform.patient_id = @patient_id)
    
  
UNION ALL
    
  SELECT 
	@patient_id as patient_id,
	dbo.fnDateTimeToFileTime(MIN(waveformdata.StartTimeUTC)) AS MIN_START_FT,
	dbo.fnDateTimeToFileTime(MAX(waveformdata.EndTimeUTC)) AS MAX_END_FT,
     [TopicFeedTypes].ChannelCode AS CHANNEL_CODE,
	 NULL as LABEL,
	int_channel_type.[Priority] as [priority],
     [WaveformData].TypeId AS CHANNEL_TYPE_ID,
     [TopicFeedTypes].SampleRate AS SAMPLE_RATE
	FROM dbo.[WaveformData]
	INNER JOIN dbo.[TopicFeedTypes] on [TopicFeedTypes].[FeedTypeId] = [WaveformData].[TypeId]

	LEFT OUTER JOIN int_channel_type 
		ON int_channel_type.channel_code=[TopicFeedTypes].ChannelCode
	where [WaveformData].[TopicSessionId] in (select TopicSessionId from v_PatientTopicSessions where PatientId = @patient_id)
  GROUP BY 
    [TopicFeedTypes].ChannelCode,
    [WaveformData].TypeId,
    [TopicFeedTypes].SampleRate,
	int_channel_type.[Priority]
	)
	ORDER BY [Priority]
END
