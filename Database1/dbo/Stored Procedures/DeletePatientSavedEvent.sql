

CREATE PROCEDURE [dbo].[DeletePatientSavedEvent]
    (
     @patient_id UNIQUEIDENTIFIER,
     @event_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM
        [dbo].[int_SavedEvent]
    WHERE
        [patient_id] = @patient_id
        AND [event_id] = @event_id;

    DELETE FROM
        [dbo].[int_SavedEvent_Waveform]
    WHERE
        [patient_id] = @patient_id
        AND [event_id] = @event_id;

    DELETE FROM
        [dbo].[int_savedevent_beat_time_log]
    WHERE
        [patient_id] = @patient_id
        AND [event_id] = @event_id;

    DELETE FROM
        [dbo].[int_savedevent_calipers]
    WHERE
        [patient_id] = @patient_id
        AND [event_id] = @event_id;

    DELETE FROM
        [dbo].[int_savedevent_event_log]
    WHERE
        [patient_id] = @patient_id
        AND [event_id] = @event_id;

    DELETE FROM
        [dbo].[int_savedevent_vitals]
    WHERE
        [patient_id] = @patient_id
        AND [event_id] = @event_id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'DeletePatientSavedEvent';

