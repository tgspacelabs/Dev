

CREATE PROCEDURE [dbo].[GetPatientVitalsTimeUpdate]
  (
  @patient_id UNIQUEIDENTIFIER,
  @after_ft   BIGINT
  )
AS
  BEGIN
    SELECT result_ft AS result_ft,
           result_dt
    FROM   dbo.int_result
    WHERE  patient_id = @patient_id AND result_ft > @after_ft    

	UNION ALL

	SELECT 
		dbo.fnDateTimeToFileTime(TimestampUTC) AS result_ft, 
		CAST(NULL AS DATETIME) as result_dt
		FROM VitalsData
	WHERE 
		TopicSessionId in
		(SELECT Id FROM TopicSessions WHERE PatientSessionId IN ( SELECT DISTINCT PatientSessionId FROM PatientSessionsMap WHERE PatientId = @patient_id ))  
		AND
		dbo.fnDateTimeToFileTime(TimestampUTC) > @after_ft
	ORDER  BY result_ft
  END

