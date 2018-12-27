
CREATE PROCEDURE [dbo].[DeleteAnalysisTime]
  (
  @UserID    UNIQUEIDENTIFIER,
  @PatientID UNIQUEIDENTIFIER
  )
AS
  BEGIN
    DELETE FROM dbo.AnalysisTime
    WHERE  ( user_id = @UserID AND patient_id = @PatientID )

  END


