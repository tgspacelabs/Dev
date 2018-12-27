
CREATE PROCEDURE [dbo].[GetAnalysisTime]
  (
  @UserID    UNIQUEIDENTIFIER,
  @PatientID UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT START_FT,
           END_FT,
           ANALYSIS_TYPE
    FROM   dbo.AnalysisTime
    WHERE  ( user_id = @UserID AND patient_id = @PatientID )

  END


