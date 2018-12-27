


CREATE PROCEDURE [dbo].[GetPatientChannelTimes]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_waveform].[patient_id],
        MIN([start_ft]) AS [MIN_START_FT],
        MAX([end_ft]) AS [MAX_END_FT],
        [channel_code] AS [CHANNEL_CODE],
        NULL AS [LABEL],
        [priority],
        [int_channel_type].[channel_type_id] AS [CHANNEL_TYPE_ID],
        [freq] AS [SAMPLE_RATE]
    FROM
        [dbo].[int_waveform]
        INNER JOIN [dbo].[int_patient_channel] ON [int_waveform].[patient_channel_id] = [int_patient_channel].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] ON [int_patient_channel].[channel_type_id] = [int_channel_type].[channel_type_id]
    GROUP BY
        [int_waveform].[patient_id],
        [CHANNEL_CODE],
        [label],
        [priority],
        [int_channel_type].[channel_type_id],
        [freq]
    HAVING
        [int_waveform].[patient_id] = @patient_id
    UNION ALL
    SELECT
        @patient_id AS [patient_id],
        [dbo].[fnDateTimeToFileTime](MIN([StartTimeUTC])) AS [MIN_START_FT],
        [dbo].[fnDateTimeToFileTime](MAX([EndTimeUTC])) AS [MAX_END_FT],
        [ChannelCode] AS [CHANNEL_CODE],
        NULL AS [LABEL],
        [priority] AS [priority],
        [TypeId] AS [CHANNEL_TYPE_ID],
        [SampleRate] AS [SAMPLE_RATE]
    FROM
        [dbo].[WaveformData]
        INNER JOIN [dbo].[TopicFeedTypes] ON [FeedTypeId] = [TypeId]
        LEFT OUTER JOIN [dbo].[int_channel_type] ON [channel_code] = [ChannelCode]
    WHERE
        [TopicSessionId] IN (SELECT
                                [TopicSessionId]
                             FROM
                                [dbo].[v_PatientTopicSessions]
                             WHERE
                                [PatientId] = @patient_id)
    GROUP BY
        [ChannelCode],
        [TypeId],
        [SampleRate],
        [priority]
    ORDER BY
        [priority];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientChannelTimes';

