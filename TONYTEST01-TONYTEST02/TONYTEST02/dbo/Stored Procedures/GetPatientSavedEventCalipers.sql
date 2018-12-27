
CREATE PROCEDURE [dbo].[GetPatientSavedEventCalipers]
  (
  @patient_id UNIQUEIDENTIFIER,
  @event_id   UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT channel_type,
           caliper_type,
           calipers_orientation,
           caliper_text,
           caliper_start_ms,
           caliper_end_ms,
           caliper_top,
           caliper_bottom
    FROM   int_savedevent_calipers
    WHERE  patient_id = @patient_id AND event_id = @event_id
  END


