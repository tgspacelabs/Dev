
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
	  WHERE 
	  TopicSessionId in
	  (SELECT Id FROM TopicSessions WHERE PatientSessionId in ( SELECT DISTINCT PatientSessionId FROM PatientSessionsMap WHERE PatientId = @patient_id ))

		   
  ORDER BY [start_ft]
END

