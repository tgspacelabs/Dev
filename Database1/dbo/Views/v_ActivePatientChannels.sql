

/*This view is used to get the latest channel types from waveforms and topics from non waveform*/
CREATE VIEW [dbo].[v_ActivePatientChannels]
AS
SELECT
    [NonWaveformChannelTypes].[TypeId],
    [NonWaveformChannelTypes].[TopicTypeId],
    [NonWaveformChannelTypes].[PatientId],
    CASE WHEN [NonWaveformChannelTypes].[EndTimeUTC] IS NULL THEN 1
         ELSE NULL
    END AS [Active]
FROM
    (SELECT DISTINCT
        [TopicTypeId],
        [vpts].[PatientId],
        NULL AS [TypeId],
        [EndTimeUTC]
     FROM
        [dbo].[TopicSessions]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [TopicSessions].[Id] = [vpts].[TopicSessionId]
        INNER JOIN [dbo].[TopicTypes] ON [TopicTypes].[Id] = [TopicTypeId]
     WHERE
        [TopicTypeId] IN (SELECT
                            [TopicTypeId]
                          FROM
                            [dbo].[v_LegacyChannelTypes]
                          WHERE
                            [TypeId] IS NULL)
    ) AS [NonWaveformChannelTypes]
UNION ALL
(SELECT
    [WAVEFRM].[TypeId],
    [TopicTypeId],
    [vpts].[PatientId],
    CASE WHEN [TopicSessions].[EndTimeUTC] IS NULL THEN 1
         ELSE NULL
    END AS [Active]
 FROM
    [dbo].[WaveformLiveData] AS [WAVEFRM]
    INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[TopicInstanceId] = [WAVEFRM].[TopicInstanceId]
    INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [TopicSessions].[Id] = [vpts].[TopicSessionId]
 GROUP BY
    [WAVEFRM].[TypeId],
    [TopicTypeId],
    [vpts].[PatientId],
    [TopicSessions].[EndTimeUTC]
 UNION
 SELECT DISTINCT
    [TopicTypeId] AS [TypeId],
    [TopicTypeId],
    [vpts].[PatientId],
    CASE WHEN [EndTimeUTC] IS NULL THEN 1
         ELSE NULL
    END AS [Active]
 FROM
    [dbo].[VitalsData]
    INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [VitalsData].[TopicSessionId]
    INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [TopicSessions].[Id] = [vpts].[TopicSessionId]
 WHERE
    [TopicTypeId] NOT IN (SELECT DISTINCT
                            [TopicTypeId]
                          FROM
                            [dbo].[WaveformData]
                            INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [TopicSessionId])
    AND [TopicTypeId] IN (SELECT
                            [TopicTypeId]
                          FROM
                            [dbo].[v_LegacyChannelTypes]
                          WHERE
                            [TypeId] IS NOT NULL)
);

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Gets the latest channel types from waveforms and topics from non-waveform.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_ActivePatientChannels';

