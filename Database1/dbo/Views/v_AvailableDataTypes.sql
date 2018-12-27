CREATE VIEW [dbo].[v_AvailableDataTypes]
WITH
     SCHEMABINDING
AS
SELECT
    [NonWaveformChannelTypes].[TypeId],
    [NonWaveformChannelTypes].[TopicTypeId],
    [NonWaveformChannelTypes].[DeviceSessionId],
    [NonWaveformChannelTypes].[PatientId],
    CASE WHEN [NonWaveformChannelTypes].[EndTimeUTC] IS NULL THEN 1
         ELSE NULL
    END AS [Active]
FROM
    (SELECT DISTINCT
        [ts].[TopicTypeId],
        [ts].[DeviceSessionId],
        [vpts].[PatientId],
        NULL AS [TypeId],
        [ts].[EndTimeUTC]
     FROM
        [dbo].[TopicSessions] AS [ts]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [vpts].[TopicSessionId] = [ts].[Id]
        INNER JOIN [dbo].[TopicTypes] AS [tt] ON [tt].[Id] = [ts].[TopicTypeId]
     WHERE
        [ts].[TopicTypeId] IN (SELECT
                                [vlct].[TopicTypeId]
                               FROM
                                [dbo].[v_LegacyChannelTypes] AS [vlct]
                               WHERE
                                [vlct].[TypeId] IS NULL)
    ) AS [NonWaveformChannelTypes]
UNION ALL
(SELECT 
DISTINCT
    [wd].[TypeId],
    [ts].[TopicTypeId],
    [ts].[DeviceSessionId],
    [vpts].[PatientId],
    [Active] = CASE WHEN [ts].[EndTimeUTC] IS NULL THEN 1
                    ELSE NULL
               END
 FROM
    [dbo].[WaveformData] AS [wd]
    INNER JOIN [dbo].[TopicSessions] AS [ts] ON [ts].[Id] = [wd].[TopicSessionId]
    INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [vpts].[TopicSessionId] = [ts].[Id]
 UNION ALL
 SELECT  
DISTINCT
    [ts].[TopicTypeId] AS [TypeId],
    [ts].[TopicTypeId],
    [ts].[DeviceSessionId],
    [vpts].[PatientId],
    CASE WHEN [ts].[EndTimeUTC] IS NULL THEN 1
         ELSE NULL
    END AS [Active]
 FROM
    [dbo].[VitalsData] AS [vd]
    INNER JOIN [dbo].[TopicSessions] AS [ts] ON [ts].[Id] = [vd].[TopicSessionId]
    INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [vpts].[TopicSessionId] = [ts].[Id]
 WHERE
    [ts].[TopicTypeId] NOT IN (SELECT DISTINCT
                                [ts].[TopicTypeId]
                               FROM
                                [dbo].[WaveformData] AS [wd]
                                INNER JOIN [dbo].[TopicSessions] AS [ts] ON [ts].[Id] = [wd].[TopicSessionId])
    AND [ts].[TopicTypeId] IN (SELECT
                                [vlct].[TopicTypeId]
                               FROM
                                [dbo].[v_LegacyChannelTypes] AS [vlct]
                               WHERE
                                [vlct].[TypeId] IS NOT NULL)
);

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_AvailableDataTypes';

