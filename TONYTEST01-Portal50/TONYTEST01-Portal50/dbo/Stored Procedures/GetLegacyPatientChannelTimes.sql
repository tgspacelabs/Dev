
CREATE PROCEDURE [dbo].[GetLegacyPatientChannelTimes] 
(
@patient_id UNIQUEIDENTIFIER
) 
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
  where (int_waveform.patient_id = @patient_id)
  GROUP BY 
    int_waveform.patient_id,
    int_channel_type.channel_code,
    int_channel_type.label,
    int_channel_type.priority,
    int_channel_type.channel_type_id,
    int_channel_type.freq)
	ORDER BY int_channel_type.priority
END
