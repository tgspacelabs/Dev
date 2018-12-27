CREATE PROCEDURE [dbo].[GetMinMaxPatientTimes] 
(
@patient_id AS [DPATIENT_ID],
@getAll as bit = 1
) AS
BEGIN

  DECLARE @l_patient_id DPATIENT_ID = @patient_id

  IF  @getAll = 0 
  BEGIN   	
    SELECT
        MIN([start_ft]) as [START_FT],
        MAX([end_ft]) as [END_FT]
    FROM [dbo].[int_waveform]
    WHERE [patient_id] = @patient_id
  END
  ELSE 
    BEGIN 
      SELECT 
        MIN(START_FT) AS START_FT,
        MAX(END_FT) as END_FT
      FROM 
      (		
        SELECT 
            dbo.fnDateTimeToFileTime(MIN([wd].StartTimeUTC)) AS [START_FT],
            dbo.fnDateTimeToFileTime(MAX([wd].EndTimeUTC)) AS [END_FT]
            FROM dbo.WaveformData AS [wd]
                INNER JOIN dbo.TopicSessions AS [ts] ON [wd].TopicSessionId = [ts].Id
            WHERE
            [ts].PatientSessionId IN
            (
            SELECT PatientSessionId
                FROM dbo.PatientSessionsMap
                INNER JOIN
                (
                    SELECT MAX(Sequence) AS MaxSeq
                        FROM dbo.PatientSessionsMap
                        GROUP BY PatientSessionId
                ) AS PatientSessionMaxSeq
                    ON  Sequence = PatientSessionMaxSeq.MaxSeq
                WHERE PatientSessionsMap.PatientId = @l_patient_id
            )
    
            UNION ALL
    
        SELECT
            MIN([start_ft]) as [START_FT],
            MAX([end_ft]) as [END_FT]
        FROM [dbo].[int_waveform]
        WHERE [patient_id] = @patient_id

      ) AS [ComboWaveform]
  END;
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the minimum and maximum patient times from waveform data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetMinMaxPatientTimes';

