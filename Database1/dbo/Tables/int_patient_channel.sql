CREATE TABLE [dbo].[int_patient_channel] (
    [patient_channel_id] UNIQUEIDENTIFIER NOT NULL,
    [patient_monitor_id] UNIQUEIDENTIFIER NOT NULL,
    [patient_id]         UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id]    UNIQUEIDENTIFIER NULL,
    [monitor_id]         UNIQUEIDENTIFIER NOT NULL,
    [module_num]         INT              NOT NULL,
    [channel_num]        INT              NOT NULL,
    [channel_type_id]    UNIQUEIDENTIFIER NULL,
    [collect_sw]         TINYINT          NULL,
    [active_sw]          TINYINT          NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [pkey_ndx]
    ON [dbo].[int_patient_channel]([patient_id] ASC, [monitor_id] ASC, [module_num] ASC, [channel_num] ASC, [patient_monitor_id] ASC, [channel_type_id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [patient_channel_ndx1]
    ON [dbo].[int_patient_channel]([patient_channel_id] ASC, [channel_type_id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains channel data active for a given patient. Each record is uniquely identified by the patient_channel_id, monitor_id and patient_id.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_patient_channel';

