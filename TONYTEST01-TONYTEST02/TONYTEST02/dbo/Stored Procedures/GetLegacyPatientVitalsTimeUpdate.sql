
CREATE PROCEDURE [dbo].[GetLegacyPatientVitalsTimeUpdate]
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
	ORDER  BY result_ft
  END

