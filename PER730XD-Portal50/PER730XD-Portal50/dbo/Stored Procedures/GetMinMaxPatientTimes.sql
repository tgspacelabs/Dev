

CREATE PROCEDURE [dbo].[GetMinMaxPatientTimes] 
(
@patient_id AS [DPATIENT_ID],
@getAll as bit = 1
) AS
BEGIN
  IF  @getAll = 0 
  BEGIN       
    SELECT
        MIN([START_FT]) as [START_FT],
        MAX([END_FT]) as [END_FT]
    FROM [dbo].[int_waveform]
    WHERE [PATIENT_ID] = @patient_id
  END
  ELSE 
    BEGIN 
      SELECT 
        MIN(START_FT) AS START_FT,
        MAX(END_FT) as END_FT
      FROM 
      (        
        SELECT 
            dbo.fnDateTimeToFileTime(MIN(StartTimeUTC)) as START_FT,
            dbo.fnDateTimeToFileTime(MAX(EndTimeUTC)) as END_FT
            FROM WaveformData 
            WHERE
            [WaveformData].TopicSessionId IN (SELECT Id FROM TopicSessions WHERE PatientSessionId IN ( SELECT DISTINCT PatientSessionId FROM PatientSessionsMap WHERE PatientId = @patient_id ))
    
            UNION ALL
    
        SELECT
            MIN([START_FT]) as [START_FT],
            MAX([END_FT]) as [END_FT]
        FROM [dbo].[int_waveform]
        WHERE [PATIENT_ID] = @patient_id

      ) AS [ComboWaveform]
  END;
END
