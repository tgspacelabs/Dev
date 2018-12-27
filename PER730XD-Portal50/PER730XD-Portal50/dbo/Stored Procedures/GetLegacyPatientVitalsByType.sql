
CREATE PROCEDURE [dbo].[GetLegacyPatientVitalsByType] (@patient_id UNIQUEIDENTIFIER, @type int)
AS
BEGIN
    SELECT 
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
ORDER BY 
  RESULT_FILE_TIME asc
END
