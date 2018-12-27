
CREATE PROCEDURE [dbo].[GetPatientVitalsByTypeUpdate]
  (
  @patient_id    UNIQUEIDENTIFIER,
  @type          INT,
  @seq_num_after BIGINT,
  @dateAfter	 BIGINT
  )
AS
  BEGIN
   
   declare @l_dateAfter DATETIME=dbo.fnFileTimeToDateTime(@dateAfter)

    ( SELECT RESULT.result_value AS VALUE,
           CAST(NULL AS DATETIME) AS RESULT_TIME,
           RESULT.Sequence AS SEQ_NUM,
           RESULT.result_ft AS RESULT_FILE_TIME
    FROM   int_result AS RESULT
           INNER JOIN int_misc_code AS CODE
             ON RESULT.test_cid = CODE.code_id
    WHERE  ( RESULT.patient_id = @patient_id ) AND ( CODE.code_id = @type ) AND ( RESULT.Sequence > @seq_num_after )

	UNION ALL  

	SELECT 
	  VitalsData.Value AS VALUE, 	  
	  CAST(NULL AS DATETIME) AS RESULT_TIME,	  
	  0 AS SEQ_NUM,
	  dbo.fnDateTimeToFileTime(VitalsData.TimeStampUTC) AS RESULT_FILE_TIME
	  FROM VitalsData
	  INNER JOIN 
	  GdsCodeMap ON
		GdsCodeMap.CodeId = @type AND 
		GdsCodeMap.FeedTypeId = VitalsData.FeedTypeId AND
		GdsCodeMap.Name = VitalsData.Name
	  WHERE VitalsData.TopicSessionId in (SELECT DISTINCT Id FROM TopicSessions WHERE PatientSessionId in (SELECT DISTINCT PatientSessionId FROM PatientSessionsMap WHERE PatientId = @patient_id))
	  AND (TimeStampUTC > @l_dateAfter)
    )
    ORDER  BY RESULT_FILE_TIME ASC
  END

