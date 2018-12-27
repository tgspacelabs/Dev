CREATE PROCEDURE [dbo].[GetPatientVitalsTimeUpdate]
    (
    @patient_id UNIQUEIDENTIFIER,
    @after_ft BIGINT)
AS
BEGIN
    SELECT
        [ir].[result_ft] AS [result_ft],
        [ir].[result_dt]
    FROM [dbo].[int_result] AS [ir]
    WHERE [ir].[patient_id] = @patient_id
          AND [result_ft] > @after_ft

    UNION ALL

    SELECT
        [result_ft].[FileTime] AS [result_ft],
        CAST(NULL AS DATETIME) AS [result_dt]
    FROM [dbo].[VitalsData] AS [vd]
        INNER JOIN [dbo].[TopicSessions] AS [ts]
            ON [ts].[Id] = [vd].[TopicSessionId]
        CROSS APPLY [dbo].[fntDateTimeToFileTime]([vd].[TimestampUTC]) AS [result_ft]
    WHERE [ts].[PatientSessionId] IN (SELECT [psm].[PatientSessionId]
                                      FROM [dbo].[PatientSessionsMap] AS [psm]
                                          INNER JOIN (SELECT MAX([psm2].[Sequence]) AS [MaxSeq]
                                                      FROM [dbo].[PatientSessionsMap] AS [psm2]
                                                      GROUP BY [psm2].[PatientSessionId]) AS [PatientSessionMaxSeq]
                                              ON [psm].[Sequence] = [PatientSessionMaxSeq].[MaxSeq]
                                      WHERE [psm].[PatientId] = @patient_id)
          AND [result_ft].[FileTime] > @after_ft
    ORDER BY [result_ft];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the patients'' vitals time update.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsTimeUpdate';

