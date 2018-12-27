
CREATE PROCEDURE [dbo].[SetPatientDataCollect]
  (
  @patientId UNIQUEIDENTIFIER
  )
AS
  BEGIN
    UPDATE dbo.int_patient_monitor
    SET    live_until_dt = DATEADD( MINUTE,
                                    3,
                                    GetDate( ) )
    WHERE  patient_Id = @patientId 
    AND active_sw=1
  END

