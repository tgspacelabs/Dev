
CREATE PROCEDURE [dbo].[GetPatientVitalsTimeUpdate]
    (
     @patient_id UNIQUEIDENTIFIER,
     @after_ft BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [result_ft] AS [result_ft],
        [result_dt]
    FROM
        [dbo].[int_result]
    WHERE
        [patient_id] = @patient_id
        AND [result_ft] > @after_ft
    UNION ALL
    SELECT
        [dbo].[fnDateTimeToFileTime]([TimestampUTC]) AS [result_ft],
        CAST(NULL AS DATETIME) AS [result_dt]
    FROM
        [dbo].[VitalsData]
    WHERE
        [TopicSessionId] IN (SELECT
                                [Id]
                             FROM
                                [dbo].[TopicSessions]
                             WHERE
                                [PatientSessionId] IN (SELECT DISTINCT
                                                        [PatientSessionId]
                                                       FROM
                                                        [dbo].[PatientSessionsMap]
                                                       WHERE
                                                        [PatientId] = @patient_id))
        AND [dbo].[fnDateTimeToFileTime]([TimestampUTC]) > @after_ft
    ORDER BY
        [result_ft];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsTimeUpdate';

