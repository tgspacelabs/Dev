CREATE PROCEDURE [dbo].[DeletePatientSavedEvent]
(
    @patient_id UNIQUEIDENTIFIER,
    @event_id   UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[int_savedevent]
    WHERE patient_id = @patient_id AND event_id = @event_id

    DELETE FROM [dbo].[int_savedevent_waveform]
    WHERE patient_id = @patient_id AND event_id = @event_id

    DELETE FROM [dbo].[int_savedevent_beat_time_log]
    WHERE patient_id = @patient_id AND event_id = @event_id

    DELETE FROM [dbo].[int_savedevent_calipers]
    WHERE patient_id = @patient_id AND event_id = @event_id

    DELETE FROM [dbo].[int_savedevent_event_log]
    WHERE patient_id = @patient_id AND event_id = @event_id

    DELETE FROM [dbo].[int_savedevent_vitals]
    WHERE patient_id = @patient_id AND event_id = @event_id
END
