
CREATE PROCEDURE [dbo].[GetPatientVitalsByTypes] (@patient_id UNIQUEIDENTIFIER, @types dbo.VitalType READONLY)
AS
BEGIN
	SELECT 
	  Result.result_value AS VALUE, 
	  Result.obs_start_dt AS RESULT_TIME,
	  Result.Sequence AS SEQ_NUM,
	  Result.result_ft AS RESULT_FILE_TIME,
	  Code.code as GDS_CODE
	FROM 
	  int_result AS Result 
	  INNER JOIN int_misc_code AS Code ON Result.test_cid = Code.code_id 
	WHERE
	  (Result.patient_id = @patient_id) AND 
	  Code.code in (select GdsCode from @types)
  
UNION ALL  

select 
	  Result.ResultValue AS VALUE,
	  CAST(NULL AS DATETIME) AS RESULT_TIME,
	  ROW_NUMBER() OVER (ORDER BY GdsCode, Result.DateTimeStampUTC)AS SEQ_NUM,
	  dbo.fnDateTimeToFileTime(Result.DateTimeStampUTC) AS RESULT_FILE_TIME,
	  Result.GdsCode as GDS_CODE
	  from v_VitalsData Result
	  
	  where TopicSessionId in
	  (select TopicSessionId from v_PatientTopicSessions where PatientId=@patient_id)
	  and GdsCode in (select GdsCode from @types)
  
ORDER BY 
  RESULT_FILE_TIME asc
END

