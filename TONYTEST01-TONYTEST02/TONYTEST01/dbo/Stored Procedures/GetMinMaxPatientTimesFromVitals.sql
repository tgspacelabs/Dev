

CREATE PROCEDURE [dbo].[GetMinMaxPatientTimesFromVitals] 
(@patient_id as [DPATIENT_ID],
 @getAll as bit = 1
) AS
BEGIN
IF  @getAll = 0 
  BEGIN   
	SELECT
	MIN([RESULT_FT]) AS START_FT,
	MAX([RESULT_FT]) AS END_FT
	FROM [dbo].[int_result]
	WHERE [PATIENT_ID] = @patient_id
  END
  ELSE
  BEGIN
	  SELECT 
		MIN([START_FT]) AS [START_FT], 
		MAX([END_FT])   AS [END_FT]
	  FROM 
	  (
		SELECT
			dbo.fnDateTimeToFileTime(MIN(TimeStampUTC)) AS [START_FT], 
			dbo.fnDateTimeToFileTime(MAX(TimeStampUTC)) AS [END_FT]

		FROM VitalsData
		WHERE [TopicSessionId] IN
		(
			SELECT [TopicSessionId]
			FROM [dbo].[v_PatientTopicSessions]
			WHERE [v_PatientTopicSessions].[PatientId]=@patient_id
		)	
		UNION ALL	
		SELECT
			MIN([RESULT_FT]) AS START_FT,
			MAX([RESULT_FT]) AS END_FT
		FROM [dbo].[int_result]
		WHERE [PATIENT_ID] = @patient_id

	  ) AS [ComboWaveform]
	  END;
END
