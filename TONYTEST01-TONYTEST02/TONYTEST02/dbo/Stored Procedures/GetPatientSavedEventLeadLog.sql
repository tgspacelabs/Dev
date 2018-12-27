
CREATE PROCEDURE [dbo].[GetPatientSavedEventLeadLog]
  (
  @patient_id      AS UNIQUEIDENTIFIER,
  @event_id        AS UNIQUEIDENTIFIER,
  @primary_channel AS BIT,
  @timetag_type    AS INT
  )
AS
  BEGIN
    SELECT lead_type AS LEADTYPE,
           start_ms AS STARTMS
    FROM   int_savedevent_event_log
    WHERE  patient_id = @patient_id AND event_id = @event_id AND primary_channel = @primary_channel AND timetag_type = @timetag_type
  END


