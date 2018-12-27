
CREATE PROCEDURE [dbo].[GetSavedEventBeatTimeLog]
  (
  @patient_id UNIQUEIDENTIFIER,
  @event_id   UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT patient_start_ft AS PATIENT_FT,
           start_ft AS START_FT,
           num_beats AS NUM_BEATS,
           sample_rate AS SAMPLE_RATE,
           beat_data AS BEAT_DATA
    FROM   int_savedevent_beat_time_log
    WHERE  ( patient_id = @patient_id AND event_id = @event_id )
  END

