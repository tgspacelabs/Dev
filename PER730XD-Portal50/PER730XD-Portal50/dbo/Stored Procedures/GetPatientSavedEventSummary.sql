
CREATE PROCEDURE [dbo].[GetPatientSavedEventSummary]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT event_id AS ID,
           start_ms,
           duration,
           start_dt,
           title,
           comment,
           sweep_speed,
           minutes_per_page,
           thumbnailChannel
    FROM   int_savedevent
    WHERE  patient_id = @patient_id
    ORDER  BY start_dt DESC
  END

