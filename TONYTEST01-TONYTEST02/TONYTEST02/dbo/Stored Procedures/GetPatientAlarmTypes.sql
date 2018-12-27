
CREATE PROCEDURE [dbo].[GetPatientAlarmTypes] (@patient_id UNIQUEIDENTIFIER, @start_ft bigint, @end_ft bigint) 
AS
BEGIN
  SELECT 
      DISTINCT int_channel_type.channel_code AS TYPE,
      int_alarm.alarm_cd AS TITLE
   FROM 
      int_alarm 
   INNER JOIN int_patient_channel ON int_alarm.patient_channel_id = int_patient_channel.patient_channel_id
   INNER JOIN int_channel_type ON int_patient_channel.channel_type_id = int_channel_type.channel_type_id 
   WHERE 
      int_alarm.patient_id = @patient_id AND 
      int_alarm.alarm_level > 0 AND
      ((@start_ft < int_alarm.end_ft AND @end_ft >= int_alarm.start_ft) OR 
      (@end_ft >= int_alarm.start_ft AND int_alarm.end_ft is null)) 
      
UNION ALL

select ChannelCode as TYPE,
	   Title as TITLE 
	   from
	v_GeneralAlarms where 
	AlarmId in 
	(SELECT AlarmId from GeneralAlarmsData where
		TopicSessionId in 
			(select TopicSessionId from v_PatientTopicSessions where PatientId = @patient_id)
		AND
		((dbo.fnFileTimeToDateTime(@start_ft) < EndDateTime AND dbo.fnFileTimeToDateTime(@end_ft) >= StartDateTime) OR 
		(dbo.fnFileTimeToDateTime(@end_ft) >= StartDateTime AND EndDateTime is null)) 
		AND
		PriorityWeightValue > 0
	)

UNION ALL
	
select ChannelCode as TYPE,
	   AlarmType as TITLE 
	   from
	v_LimitAlarms where 
	AlarmId in 
	(SELECT AlarmId from LimitAlarmsData where
		TopicSessionId in 
			(select TopicSessionId from v_PatientTopicSessions where PatientId = @patient_id)
		AND
		((dbo.fnFileTimeToDateTime(@start_ft) < EndDateTime AND dbo.fnFileTimeToDateTime(@end_ft) >= StartDateTime) OR 
		(dbo.fnFileTimeToDateTime(@end_ft) >= StartDateTime AND EndDateTime is null)) 
		AND
		PriorityWeightValue > 0
	)
END

