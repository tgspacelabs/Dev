
CREATE PROCEDURE [dbo].[GetLegacyPatientVitalsTypes] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN
	SELECT 
		Code.code_id AS [TYPE],
		Code.code AS CODE,
		Code.int_keystone_cd AS UNITS
	  FROM 
	  int_misc_code Code
	  INNER JOIN 
	  (
		  select distinct test_cid 
		  from int_result  where patient_id = @patient_id
	  ) result_cid
	  on result_cid.test_cid = Code.code_id
END

