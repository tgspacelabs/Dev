

CREATE PROCEDURE [dbo].[GetPatientChannelList]
    (
     @patientId UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [channel_type_id] AS [PATIENT_CHANNEL_ID],
        [channel_type_id] AS [CHANNEL_TYPE_ID]
    FROM
        [dbo].[int_patient_channel]
    WHERE
        [patient_id] = @patientId
        AND [active_sw] = 1
    UNION ALL
    SELECT DISTINCT
        [TypeIds].[TypeId] AS [PATIENT_CHANNEL_ID],
        [TypeIds].[TypeId] AS [CHANNEL_TYPE_ID]
    FROM
        (SELECT
            [TypeId]
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
            AND [TopicSessions].[EndTimeUTC] IS NULL
         UNION ALL
         SELECT
            [TopicSessions].[TopicTypeId]
         FROM
            [dbo].[TopicSessions] -- add non-waveform types
            INNER JOIN [dbo].[TopicFeedTypes] ON [FeedTypeId] = [TopicSessions].[TopicTypeId]
         WHERE
            [Id] IN (SELECT
                        [TopicSessionId]
                     FROM
                        [dbo].[v_PatientTopicSessions]
                     WHERE
                        [PatientId] = @patientId)
            AND [EndTimeUTC] IS NULL
        ) [TypeIds];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientChannelList';

