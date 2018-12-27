CREATE TABLE [dbo].[int_savedevent_vitals] (
    [patient_id]   UNIQUEIDENTIFIER NOT NULL,
    [event_id]     UNIQUEIDENTIFIER NOT NULL,
    [gds_code]     NVARCHAR (80)    NOT NULL,
    [result_dt]    DATETIME         NULL,
    [result_value] NVARCHAR (200)   NULL,
    CONSTRAINT [PK_int_savedevent_vitals_patient_id_event_id_gds_code] PRIMARY KEY CLUSTERED ([patient_id] ASC, [event_id] ASC, [gds_code] ASC),
    CONSTRAINT [int_SavedEvent_int_savedevent_vitals] FOREIGN KEY ([patient_id], [event_id]) REFERENCES [dbo].[int_SavedEvent] ([patient_id], [event_id]) ON DELETE CASCADE
);

