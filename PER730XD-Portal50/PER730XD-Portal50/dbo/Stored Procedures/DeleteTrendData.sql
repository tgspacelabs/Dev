
CREATE PROCEDURE [dbo].[DeleteTrendData]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID
  )
AS
  BEGIN
    DELETE dbo.TrendData
    WHERE  ( user_id = @UserID AND patient_id = @PatientID )
  END

