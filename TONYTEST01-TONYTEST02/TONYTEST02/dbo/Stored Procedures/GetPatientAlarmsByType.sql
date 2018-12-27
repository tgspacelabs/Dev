
CREATE PROCEDURE [dbo].[GetPatientAlarmsByType]
  (
  @patient_id UNIQUEIDENTIFIER,
  @alarm_type INT,
  @start_ft   BIGINT,
  @end_ft     BIGINT
  )
AS
  BEGIN
    SELECT alarm_id AS ID,
           alarm_cd AS TITLE,
           start_ft AS START_FT,
           end_ft AS END_FT,
           start_dt AS START_DT,
           removed,
           alarm_level AS PRIORITY
    FROM   int_alarm
           INNER JOIN int_patient_channel
             ON int_alarm.patient_channel_id = int_patient_channel.patient_channel_id
           INNER JOIN int_channel_type
             ON int_patient_channel.channel_type_id = int_channel_type.channel_type_id
    WHERE  int_alarm.patient_id = @patient_id AND int_channel_type.channel_code = @alarm_type AND ( ( @start_ft < int_alarm.end_ft AND @end_ft >= int_alarm.start_ft )  OR ( @end_ft >= int_alarm.start_ft AND int_alarm.end_ft IS NULL ) )
    ORDER  BY start_ft
  END


