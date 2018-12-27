
CREATE PROCEDURE [dbo].[SaveEventMonitorEventLog]
  (
  @patient_id         AS UNIQUEIDENTIFIER,
  @event_id           AS UNIQUEIDENTIFIER,
  @timetag_type       AS INT,
  @monitor_event_type AS INT,
  @start_ms           AS BIGINT,
  @end_ms             AS BIGINT
  )
AS
  BEGIN
    INSERT INTO int_savedevent_event_log
                (patient_id,
                 event_id,
                 timetag_type,
                 monitor_event_type,
                 start_ms,
                 end_ms)
    VALUES      ( @patient_id,
                  @event_id,
                  @timetag_type,
                  @monitor_event_type,
                  @start_ms,
                  @end_ms)
  END


