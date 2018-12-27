
CREATE PROCEDURE [dbo].[WriteAnalysisTime]
  (
  @UserID    UNIQUEIDENTIFIER,
  @PatientID UNIQUEIDENTIFIER,
  @StartFt   BIGINT,
  @EndFt     BIGINT,
  @AnalysisType INT
  )
AS
  BEGIN
    INSERT INTO dbo.AnalysisTime
                (user_id,
                 patient_id,
                 start_ft,
                 end_ft,
		 analysis_type)
    VALUES      (@UserID,
                 @PatientID,
                 @StartFt,
                 @EndFt,
		 @AnalysisType)
  END



