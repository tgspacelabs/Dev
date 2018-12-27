CREATE VIEW [dbo].[v_PatientTopicSessions]
WITH
     SCHEMABINDING
AS
SELECT
    [ts].[Id] AS [TopicSessionId],
    [PatientMap].[PatientId]
FROM
    [dbo].[PatientSessionsMap] AS [PatientMap]
    INNER JOIN (SELECT
                    [psm].[PatientSessionId],
                    MAX([psm].[Sequence]) AS [MaxSequence]
                FROM
                    [dbo].[PatientSessionsMap] AS [psm]
                GROUP BY
                    [psm].[PatientSessionId]
               ) AS [PatientMax] ON [PatientMax].[PatientSessionId] = [PatientMap].[PatientSessionId]
                                    AND [PatientMax].[MaxSequence] = [PatientMap].[Sequence]
    INNER JOIN [dbo].[TopicSessions] AS [ts] ON [ts].[PatientSessionId] = [PatientMap].[PatientSessionId];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_PatientTopicSessions';

