CREATE PROCEDURE [dbo].[GetPatientWaveFormTimeHistory] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN
    SELECT 
        [start_ft], 
        [start_dt]
    FROM 
        [dbo].[int_waveform] 
    WHERE 
        [patient_id] = @patient_id     

    UNION ALL

    SELECT 
        dbo.fnDateTimeToFileTime([WaveformData].StartTimeUTC) AS [start_ft],
        CAST(NULL AS DATETIME) AS [start_dt]
    FROM
        [dbo].[WaveformData] 
      INNER JOIN [dbo].[TopicSessions] ON TopicSessions.Id = WaveformData.TopicSessionId
        WHERE TopicSessions.PatientSessionId IN
        (
            SELECT PatientSessionId
            FROM dbo.PatientSessionsMap
            INNER JOIN
            (
            SELECT MAX(Sequence) AS MaxSeq
                FROM dbo.PatientSessionsMap
                GROUP BY PatientSessionId
            ) AS PatientSessionMaxSeq
                ON Sequence = PatientSessionMaxSeq.MaxSeq
            WHERE PatientId = @patient_id
        )
           
    ORDER BY [start_ft];
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the patients'' waveform time history.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientWaveFormTimeHistory';

