

CREATE PROCEDURE [dbo].[GetPatientWaveFormDataByChannels]
    (
     @ChannelTypes [dbo].[StringList] READONLY,
     @patientId UNIQUEIDENTIFIER
	 )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Waveforms].[PATIENT_CHANNEL_ID],
        [Waveforms].[patient_monitor_id],
        [Waveforms].[START_DT],
        [Waveforms].[END_DT],
        [Waveforms].[START_FT],
        [Waveforms].[END_FT],
        [Waveforms].[COMPRESS_METHOD],
        [Waveforms].[WAVEFORM_DATA],
        [Waveforms].[TOPIC_INSTANCE_ID]
    FROM
        (SELECT
            ROW_NUMBER() OVER (PARTITION BY [TypeId] ORDER BY [StartTimeUTC] DESC) AS [ROW_NUMBER],
            [TypeId] AS [PATIENT_CHANNEL_ID],
            [DeviceSessionId] AS [patient_monitor_id],
            [dbo].[fnUtcDateTimeToLocalTime]([StartTimeUTC]) AS [START_DT],
            [dbo].[fnUtcDateTimeToLocalTime]([WaveformLiveData].[EndTimeUTC]) AS [END_DT],
            [dbo].[fnDateTimeToFileTime]([StartTimeUTC]) AS [START_FT],
            [dbo].[fnDateTimeToFileTime]([WaveformLiveData].[EndTimeUTC]) AS [END_FT],
            NULL AS [COMPRESS_METHOD],
            [Samples] AS [WAVEFORM_DATA],
            [WaveformLiveData].[TopicInstanceId] AS [TOPIC_INSTANCE_ID]
         FROM
            [dbo].[WaveformLiveData]
            INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[TopicInstanceId] = [WaveformLiveData].[TopicInstanceId]
         WHERE
            [TopicSessions].[Id] IN (SELECT
                                        [TopicSessionId]
                                     FROM
                                        [dbo].[v_PatientTopicSessions]
                                     WHERE
                                        [PatientId] = @patientId)
            AND [TypeId] IN (SELECT
                                [Item] 
                             FROM
                                @ChannelTypes)
            AND [TopicSessions].[EndTimeUTC] IS NULL
        ) [Waveforms]
    WHERE
        [Waveforms].[ROW_NUMBER] = 1
    UNION ALL
    SELECT
        [pc].[channel_type_id] AS [PATIENT_CHANNEL_ID],
        [pc].[patient_monitor_id],
        [WAVFRM].[start_dt] AS [START_DT],
        [WAVFRM].[end_dt] AS [END_DT],
        [WAVFRM].[start_ft] AS [START_FT],
        [WAVFRM].[end_ft] AS [END_FT],
        [WAVFRM].[compress_method] AS [COMPRESS_METHOD],
        [WAVFRM].[waveform_data] AS [WAVEFORM_DATA],
        NULL AS [TOPIC_INSTANCE_ID]
    FROM
        [dbo].[int_patient_channel] [pc]
        LEFT OUTER JOIN [dbo].[int_waveform_live] AS [WAVFRM] ON [WAVFRM].[patient_channel_id] = [pc].[patient_channel_id]
    WHERE
        [pc].[patient_id] = @patientId
        AND [pc].[channel_type_id] IN (SELECT
                                        [Item] 
                                       FROM
                                        @ChannelTypes)
        AND [pc].[active_sw] = 1;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientWaveFormDataByChannels';

