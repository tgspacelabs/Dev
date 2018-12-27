  

  
CREATE PROCEDURE [dbo].[GetLegacyPatientWaveFormDataByChannels] 
     (
        @ChannelTypes [dbo].[StringList] READONLY, 
        @patientId UNIQUEIDENTIFIER
     ) 
AS
BEGIN  
    SELECT 
        pc.channel_type_id AS PATIENT_CHANNEL_ID,
        pc.patient_monitor_id,
        WAVFRM.start_dt AS START_DT,
        WAVFRM.end_dt AS END_DT,
        WAVFRM.start_ft AS START_FT,
        WAVFRM.end_ft AS END_FT,
        WAVFRM.compress_method AS COMPRESS_METHOD,
        WAVFRM.waveform_data AS WAVEFORM_DATA,
        NULL AS TOPIC_INSTANCE_ID
    FROM dbo.int_patient_channel pc 
    LEFT OUTER JOIN dbo.int_waveform_live AS WAVFRM
      ON WAVFRM.patient_channel_id = pc.patient_channel_id
    WHERE  pc.patient_id = @patientId 
      AND pc.channel_type_id IN (SELECT ITEM FROM @ChannelTypes)
      AND pc.active_sw=1
END
