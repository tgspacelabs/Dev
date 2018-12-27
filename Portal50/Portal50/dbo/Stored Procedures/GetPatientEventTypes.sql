
CREATE PROCEDURE [dbo].[GetPatientEventTypes]
  (
  @user_id    UNIQUEIDENTIFIER,
  @patient_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT AE.type
    FROM   dbo.AnalysisEvents AE
    WHERE  ( AE.user_id = @user_id ) AND ( AE.patient_id = @patient_id )
  END

