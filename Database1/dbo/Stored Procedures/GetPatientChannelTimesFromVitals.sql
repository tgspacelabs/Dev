

CREATE PROCEDURE [dbo].[GetPatientChannelTimesFromVitals]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        MIN([result_ft]) AS [MIN_START_FT],
        MAX([result_ft]) AS [MAX_END_FT],
        [channel_code] AS [CHANNEL_CODE],
        [label] AS [LABEL],
        [priority],
        [int_channel_type].[channel_type_id] AS [CHANNEL_TYPE_ID],
        [freq] AS [SAMPLE_RATE]
    FROM
        [dbo].[int_result],
        [dbo].[int_patient_channel]
        INNER JOIN [dbo].[int_channel_type] ON [int_patient_channel].[channel_type_id] = [int_channel_type].[channel_type_id]
    GROUP BY
        [int_result].[patient_id],
        [CHANNEL_CODE],
        [LABEL],
        [priority],
        [int_channel_type].[channel_type_id],
        [freq]
    HAVING
        [int_result].[patient_id] = @patient_id
    UNION ALL
    SELECT
        [dbo].[fnDateTimeToFileTime](MIN([TimestampUTC])) AS [MIN_START_FT],
        [dbo].[fnDateTimeToFileTime](MAX([TimestampUTC])) AS [MAX_END_FT],
        [ChannelCode] AS [CHANNEL_CODE],
        [int_channel_type].[label] AS [LABEL],
        [priority],
        [TopicFeedTypes].[FeedTypeId] AS [CHANNEL_TYPE_ID],
        [SampleRate] AS [SAMPLE_RATE]
    FROM
        [dbo].[VitalsData]
        INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [VitalsData].[TopicSessionId]
        INNER JOIN [dbo].[TopicFeedTypes] ON [TopicFeedTypes].[TopicTypeId] = [TopicSessions].[TopicTypeId]
        INNER JOIN [dbo].[int_channel_type] ON [channel_code] = [ChannelCode]
        INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId] = [TopicSessions].[Id]
    WHERE
        [PatientId] = @patient_id
        AND [SampleRate] IS NOT NULL
    GROUP BY
        [TopicFeedTypes].[FeedTypeId],
        [ChannelCode],
        [int_channel_type].[label],
        [SampleRate],
        [priority]
    ORDER BY
        [priority];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientChannelTimesFromVitals';

