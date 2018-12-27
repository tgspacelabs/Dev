
CREATE PROCEDURE [dbo].[UpdateAnalysisInsertdt]
  (
  @patient_id UNIQUEIDENTIFIER,
  @user_id    UNIQUEIDENTIFIER,
  @insert_dt  DATETIME
  )
AS
  BEGIN
    UPDATE AnalysisTime
    SET    insert_dt = @insert_dt
    WHERE  patient_id = @patient_id AND user_id = @user_id
  END


