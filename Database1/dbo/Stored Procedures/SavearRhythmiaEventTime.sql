﻿--ALTER PROCEDURE [dbo].[p_update_vital_live_temp]
--AS
--BEGIN
--	SET NOCOUNT ON;
--	DELETE int_vital_live_temp WHERE createdDT < GETDATE()-0.002 
--END
--GO

CREATE PROCEDURE [dbo].[SavearRhythmiaEventTime]
    (
     @patient_id AS DPATIENT_ID,
     @event_id AS UNIQUEIDENTIFIER,
     @timetag_type AS INT,
     @arrhythmia_event_type AS INT,
     @start_ms AS BIGINT,
     @end_ms AS BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_savedevent_event_log]
            ([patient_id],
             [event_id],
             [timetag_type],
             [arrhythmia_event_type],
             [start_ms],
             [end_ms]
            )
    VALUES
            (@patient_id,
             @event_id,
             @timetag_type,
             @arrhythmia_event_type,
             @start_ms,
             @end_ms
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'SavearRhythmiaEventTime';
