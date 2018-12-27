CREATE TABLE [dbo].[int_patient_channel] (
    [patient_channel_id] BIGINT NOT NULL,
    [patient_monitor_id] BIGINT NOT NULL,
    [patient_id]         BIGINT NOT NULL,
    [orig_patient_id]    BIGINT NULL,
    [monitor_id]         BIGINT NOT NULL,
    [module_num]         INT              NOT NULL,
    [channel_num]        INT              NOT NULL,
    [channel_type_id]    BIGINT NULL,
    [collect_sw]         TINYINT          NULL,
    [active_sw]          TINYINT          NULL,
    CONSTRAINT [FK_int_patient_channel_int_channel_type_channel_type_id] FOREIGN KEY ([channel_type_id]) REFERENCES [dbo].[int_channel_type] ([channel_type_id]),
    CONSTRAINT [FK_int_patient_channel_int_monitor_monitor_id] FOREIGN KEY ([monitor_id]) REFERENCES [dbo].[int_monitor] ([monitor_id]),
    CONSTRAINT [FK_int_patient_channel_int_patient_patient_id] FOREIGN KEY ([patient_id]) REFERENCES [dbo].[int_patient] ([patient_id])
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_int_patient_channel_patient_id_monitor_id_module_num_channel_num_patient_monitor_id_channel_type_id]
    ON [dbo].[int_patient_channel]([patient_id] ASC, [monitor_id] ASC, [module_num] ASC, [channel_num] ASC, [patient_monitor_id] ASC, [channel_type_id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_int_patient_channel_patient_monitor_id]
    ON [dbo].[int_patient_channel]([patient_monitor_id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_int_patient_channel_patient_channel_id_channel_type_id]
    ON [dbo].[int_patient_channel]([patient_channel_id] ASC, [channel_type_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains channel data active for a given patient. Each record is uniquely identified by the patient_channel_id, monitor_id and patient_id.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_patient_channel';

