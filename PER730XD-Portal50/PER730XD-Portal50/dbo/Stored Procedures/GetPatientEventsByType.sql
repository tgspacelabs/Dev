
CREATE PROCEDURE [dbo].[GetPatientEventsByType]
  (
  @user_id    UNIQUEIDENTIFIER,
  @patient_id UNIQUEIDENTIFIER,
  @type       INT
  )
AS
  BEGIN
    SELECT AE.num_events,
           AE.sample_rate,
           AE.event_data
    FROM   dbo.AnalysisEvents AE
    WHERE  ( AE.user_id = @user_id ) AND ( AE.patient_id = @patient_id ) AND ( AE.type = @type )
  END
