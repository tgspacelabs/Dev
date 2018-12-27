
CREATE PROCEDURE [dbo].[GetPatientVitalsByType] (@patient_id UNIQUEIDENTIFIER, @type int)
AS
BEGIN
    (SELECT 
      Result.result_value AS VALUE, 
      CAST(NULL AS DATETIME) AS RESULT_TIME,
      Result.Sequence AS SEQ_NUM,
      Result.result_ft AS RESULT_FILE_TIME
    FROM 
      int_result AS Result 
      INNER JOIN int_misc_code AS Code ON Result.test_cid = Code.code_id 
    WHERE
      (Result.patient_id = @patient_id) AND 
      (Code.code_id = @type) 
  
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
  )
ORDER BY 
  RESULT_FILE_TIME asc
END
