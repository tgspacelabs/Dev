
CREATE PROCEDURE [dbo].[DeleteEventData]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID
  )
AS
  BEGIN
    DELETE dbo.AnalysisEvents
    WHERE  ( user_id = @UserID AND patient_id = @PatientID )

  END


