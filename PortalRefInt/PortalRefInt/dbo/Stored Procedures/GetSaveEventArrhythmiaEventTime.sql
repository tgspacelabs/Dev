CREATE PROCEDURE [dbo].[GetSaveEventArrhythmiaEventTime]
    (
     @patient_id [dbo].[DPATIENT_ID], -- TG - Should be BIGINT
     @event_id AS BIGINT,
     @timetag_type AS INT
    )
AS
BEGIN
    SELECT
        [start_ms] AS [STARTMS],
        [end_ms] AS [ENDMS]
    FROM
        [dbo].[int_savedevent_event_log]
    WHERE
        [patient_id] = CAST(@patient_id AS BIGINT)
        AND [event_id] = @event_id
        AND [timetag_type] = @timetag_type;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetSaveEventArrhythmiaEventTime';

