
CREATE PROCEDURE [dbo].[GetPatientEventsCountByType]
  (
  @user_id    UNIQUEIDENTIFIER,
  @patient_id UNIQUEIDENTIFIER,
  @type       INT
  )
AS
  BEGIN
    SELECT AE.num_events AS EVENT_COUNT
    FROM   AnalysisEvents AE
    WHERE  ( AE.user_id = @user_id ) AND ( AE.patient_id = @patient_id ) AND ( AE.type = @type )
  END


