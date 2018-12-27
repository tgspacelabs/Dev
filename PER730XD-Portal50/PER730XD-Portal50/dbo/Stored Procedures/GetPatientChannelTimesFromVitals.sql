
CREATE PROCEDURE [dbo].[GetPatientChannelTimesFromVitals]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
 
    SELECT int_result.Patient_id,
           MIN( int_result.result_ft ) AS MIN_START_FT,
           MAX( int_result.result_ft ) AS MAX_END_FT,
           int_channel_type.channel_code AS CHANNEL_CODE,
           int_channel_type.label AS LABEL,
           int_channel_type.[Priority],
           int_channel_type.channel_type_id AS CHANNEL_TYPE_ID,
           int_channel_type.freq AS SAMPLE_RATE
    FROM   dbo.int_result,
           dbo.int_patient_channel
           INNER JOIN dbo.int_channel_type
             ON int_patient_channel.channel_type_id = int_channel_type.channel_type_id
    GROUP  BY int_result.patient_id,int_channel_type.channel_code,int_channel_type.label,int_channel_type.priority,int_channel_type.channel_type_id,int_channel_type.freq
    HAVING ( int_result.patient_id = @patient_id )

   
UNION ALL
   
        select 
        v_PatientTopicSessions.PatientId,
        dbo.fnDateTimeToFileTime(MIN(TopicSessions.BeginTimeUTC)) as MIN_START_FT,
        dbo.fnDateTimeToFileTime(MAX(TopicSessions.EndTimeUTC)) as MIN_START_FT,
        TopicFeedTypes.ChannelCode as CHANNEL_CODE,
        int_channel_type.label AS LABEL,
        int_channel_type.[priority],
        TopicFeedTypes.FeedTypeId as CHANNEL_TYPE_ID,
        TopicFeedTypes.SampleRate as SAMPLE_RATE
        from TopicSessions 
        INNER JOIN TopicFeedTypes on TopicFeedTypes.TopicTypeId = TopicSessions.TopicTypeId
        INNER JOIN int_channel_type on int_channel_type.channel_code = TopicFeedTypes.ChannelCode
        INNER JOIN v_PatientTopicSessions on v_PatientTopicSessions.TopicSessionId = TopicSessions.Id
        where PatientId = @patient_Id and TopicFeedTypes.SampleRate IS NOT NULL
        group by v_PatientTopicSessions.PatientId, TopicFeedTypes.FeedTypeId, TopicFeedTypes.ChannelCode, int_channel_type.label, TopicFeedTypes.SampleRate, int_channel_type.priority
        

ORDER  BY int_channel_type.priority
END
