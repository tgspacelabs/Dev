

CREATE PROCEDURE [dbo].[GetPatientStartftFromVitals]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
  SELECT MIN(START_FT) AS START_FT FROM
  (
		SELECT MIN( result_ft ) AS START_FT
		FROM   dbo.int_result
		WHERE  ( patient_id = @patient_id )

	UNION ALL

		SELECT dbo.fnDateTimeToFileTime(MIN(TimestampUTC)) AS START_FT
		FROM VitalsData
		WHERE 
		TopicSessionId in (select TopicSessionId from v_PatientTopicSessions where PatientId = @patient_id)
  ) AS START_FT
  END


