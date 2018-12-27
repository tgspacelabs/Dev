
CREATE PROCEDURE [dbo].[GetPatientSavedEvent]
  (
  @patient_id UNIQUEIDENTIFIER,
  @event_id   UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT start_ms,
           start_dt,
           center_ft,
           duration,
           value1,
           value2,
           title,
           comment,
           sweep_speed,
           minutes_per_page,
           print_format,
           annotate_data,
           beat_color,
           thumbnailChannel
    FROM   int_savedevent
    WHERE  patient_id = @patient_id AND event_id = @event_id
    ORDER  BY insert_dt DESC
  END

