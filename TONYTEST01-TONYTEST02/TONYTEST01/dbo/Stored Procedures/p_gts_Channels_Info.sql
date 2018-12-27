
CREATE PROCEDURE [p_gts_Channels_Info]
AS
  BEGIN
    SET DEADLOCK_PRIORITY LOW

    DECLARE
      @ActiveChannels         AS INT,
      @ActiveWaveformChannels AS INT

    SELECT @ActiveChannels = COUNT(*)
    FROM   dbo.int_patient_channel
           LEFT OUTER JOIN int_monitor
             ON ( int_patient_channel.monitor_id = int_monitor.monitor_id )
    WHERE  ( int_patient_channel.active_sw = 1 ) AND ( int_monitor.monitor_id IS NOT NULL )

    SELECT @ActiveWaveformChannels = COUNT(*)
    FROM   dbo.int_patient_channel
           LEFT OUTER JOIN int_monitor
             ON ( int_patient_channel.monitor_id = int_monitor.monitor_id )
           INNER JOIN dbo.int_channel_type
             ON ( int_patient_channel.channel_type_id = dbo.int_channel_type.channel_type_id )
    WHERE  ( int_patient_channel.active_sw = 1 ) AND ( int_monitor.monitor_id IS NOT NULL ) AND ( int_channel_type.type_cd = 'WAVEFORM' )

    SELECT @ActiveChannels AS ACTIVE_CHANNELS,
           @ActiveWaveformChannels AS ACTIVE_WAVEFORM_CHANNELS
  END

