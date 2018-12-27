CREATE TABLE [dbo].[int_savedevent_event_log] (
    [patient_id]            UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id]       UNIQUEIDENTIFIER NULL,
    [event_id]              UNIQUEIDENTIFIER NOT NULL,
    [primary_channel]       BIT              NULL,
    [timetag_type]          INT              NOT NULL,
    [lead_type]             INT              NULL,
    [monitor_event_type]    INT              NULL,
    [arrhythmia_event_type] INT              NULL,
    [start_ms]              BIGINT           NOT NULL,
    [end_ms]                BIGINT           NULL,
    CONSTRAINT [int_SavedEvent_int_savedevent_event_log] FOREIGN KEY ([patient_id], [event_id]) REFERENCES [dbo].[int_SavedEvent] ([patient_id], [event_id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_int_savedevent_event_log_1]
    ON [dbo].[int_savedevent_event_log]([patient_id] ASC, [event_id] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is designed to save savedevent lead changes and monitor events logs (lead changed log timetag_type = 12289   monitor event log timetag_type = 12290)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_savedevent_event_log';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used by lead change log', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_savedevent_event_log', @level2type = N'COLUMN', @level2name = N'primary_channel';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used by lead change and monitor events log', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_savedevent_event_log', @level2type = N'COLUMN', @level2name = N'timetag_type';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used by lead change log', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_savedevent_event_log', @level2type = N'COLUMN', @level2name = N'lead_type';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used by monitor event log', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_savedevent_event_log', @level2type = N'COLUMN', @level2name = N'monitor_event_type';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used by lead change and monitor event log', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_savedevent_event_log', @level2type = N'COLUMN', @level2name = N'start_ms';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used by monitor event log', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_savedevent_event_log', @level2type = N'COLUMN', @level2name = N'end_ms';

