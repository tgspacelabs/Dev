
CREATE PROCEDURE [dbo].[GetLegacyPatientStartftFromVitals]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
  BEGIN 
		SELECT MIN( result_ft ) AS START_FT
		FROM   dbo.int_result
		WHERE  ( patient_id = @patient_id )
  END

