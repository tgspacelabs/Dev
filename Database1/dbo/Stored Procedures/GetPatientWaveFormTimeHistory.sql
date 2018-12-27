

CREATE PROCEDURE [dbo].[GetPatientWaveFormTimeHistory]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [start_ft],
        [start_dt]
    FROM
        [dbo].[int_waveform]
    WHERE
        [patient_id] = @patient_id
    UNION ALL
    SELECT
        [dbo].[fnDateTimeToFileTime]([StartTimeUTC]) AS [start_ft],
        CAST(NULL AS DATETIME) AS [start_dt]
    FROM
        [dbo].[WaveformData]
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
    ORDER BY
        [start_ft];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientWaveFormTimeHistory';

