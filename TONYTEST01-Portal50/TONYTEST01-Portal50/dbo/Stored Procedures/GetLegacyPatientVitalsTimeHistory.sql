
CREATE PROCEDURE [dbo].[GetLegacyPatientVitalsTimeHistory] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN  
SELECT distinct
		result_ft,
		result_dt
	FROM
		dbo.int_result
	WHERE
		patient_id = @patient_id
	ORDER BY result_ft ASC
END
