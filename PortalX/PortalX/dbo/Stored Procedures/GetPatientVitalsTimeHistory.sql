CREATE PROCEDURE [dbo].[GetPatientVitalsTimeHistory]
    (@patient_id UNIQUEIDENTIFIER)
AS
BEGIN
    SELECT DISTINCT
           [ir].[result_ft],
           [ir].[result_dt]
    FROM [dbo].[int_result] AS [ir]
    WHERE [ir].[patient_id] = @patient_id

    UNION ALL

    SELECT DISTINCT
           [result_ft].[FileTime] AS [result_ft],
           [result_dt].[LocalDateTime] AS [result_dt]
    FROM [dbo].[VitalsData] AS [vd]
        INNER JOIN [dbo].[TopicSessions] AS [ts]
            ON [vd].[TopicSessionId] = [ts].[Id]
        INNER JOIN [dbo].[PatientSessionsMap] AS [psm]
            ON [ts].[PatientSessionId] = [psm].[PatientSessionId]
        INNER JOIN (SELECT MAX([psm2].[Sequence]) AS [MaxSeq]
                    FROM [dbo].[PatientSessionsMap] AS [psm2]
                    WHERE [psm2].[PatientId] = @patient_id -- Include @patient_id within the inner query to get only the patient session we requested instead of all patient sessions 
                    GROUP BY [psm2].[PatientSessionId]) AS [PatientSessionMaxSeq]
            ON [psm].[Sequence] = [PatientSessionMaxSeq].[MaxSeq]
        CROSS APPLY [dbo].[fntDateTimeToFileTime]([vd].[TimestampUTC]) AS [result_ft]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vd].[TimestampUTC]) AS [result_dt]
    WHERE [psm].[PatientId] = @patient_id
    ORDER BY [ir].[result_ft] ASC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the patients'' vitals time history.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsTimeHistory';

