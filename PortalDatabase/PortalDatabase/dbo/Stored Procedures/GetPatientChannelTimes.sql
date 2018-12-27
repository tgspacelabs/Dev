CREATE PROCEDURE [dbo].[GetPatientChannelTimes]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    (SELECT
        [int_waveform].[patient_id],
        MIN([int_waveform].[start_ft]) AS [MIN_START_FT],
        MAX([int_waveform].[end_ft]) AS [MAX_END_FT],
        [int_channel_type].[channel_code] AS [CHANNEL_CODE],
        NULL AS [LABEL],
        [int_channel_type].[priority],
        [int_channel_type].[channel_type_id] AS [CHANNEL_TYPE_ID],
        [int_channel_type].[freq] AS [SAMPLE_RATE]
     FROM
        [dbo].[int_waveform]
        INNER JOIN [dbo].[int_patient_channel] ON [int_waveform].[patient_channel_id] = [int_patient_channel].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] ON [int_patient_channel].[channel_type_id] = [int_channel_type].[channel_type_id]
     GROUP BY
        [int_waveform].[patient_id],
        [int_channel_type].[channel_code],
        [int_channel_type].[label],
        [int_channel_type].[priority],
        [int_channel_type].[channel_type_id],
        [int_channel_type].[freq]
     HAVING
        ([int_waveform].[patient_id] = @patient_id)
     UNION ALL
     SELECT
        @patient_id AS [patient_id],
        [dbo].[fnDateTimeToFileTime](MIN([waveformdata].[StartTimeUTC])) AS [MIN_START_FT],
        [dbo].[fnDateTimeToFileTime](MAX([waveformdata].[EndTimeUTC])) AS [MAX_END_FT],
        [TopicFeedTypes].[ChannelCode] AS [CHANNEL_CODE],
        NULL AS [LABEL],
        [int_channel_type].[priority] AS [priority],
        [waveformdata].[TypeId] AS [CHANNEL_TYPE_ID],
        [TopicFeedTypes].[SampleRate] AS [SAMPLE_RATE]
     FROM
        [dbo].[WaveformData]
        INNER JOIN [dbo].[TopicFeedTypes] ON [TopicFeedTypes].[FeedTypeId] = [waveformdata].[TypeId]
        LEFT OUTER JOIN [dbo].[int_channel_type] ON [int_channel_type].[channel_code] = [TopicFeedTypes].[ChannelCode]
     WHERE
        [waveformdata].[TopicSessionId] IN (SELECT
                                                [TopicSessionId]
                                            FROM
                                                [dbo].[v_PatientTopicSessions]
                                            WHERE
                                                [PatientId] = @patient_id)
     GROUP BY
        [TopicFeedTypes].[ChannelCode],
        [waveformdata].[TypeId],
        [TopicFeedTypes].[SampleRate],
        [int_channel_type].[priority]
    )
    ORDER BY
        [priority];
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientChannelTimes';

