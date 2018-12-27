CREATE TABLE [dbo].[int_savedevent_beat_time_log] (
    [patient_id]       UNIQUEIDENTIFIER NOT NULL,
    [event_id]         UNIQUEIDENTIFIER NOT NULL,
    [patient_start_ft] BIGINT           NOT NULL,
    [start_ft]         BIGINT           NOT NULL,
    [num_beats]        INT              NOT NULL,
    [sample_rate]      SMALLINT         NOT NULL,
    [beat_data]        IMAGE            NOT NULL,
    CONSTRAINT [PK_int_savedevent_beat_time_log] PRIMARY KEY CLUSTERED ([patient_id] ASC, [event_id] ASC),
    CONSTRAINT [int_SavedEvent_int_savedevent_beat_time_log] FOREIGN KEY ([patient_id], [event_id]) REFERENCES [dbo].[int_SavedEvent] ([patient_id], [event_id]) ON DELETE CASCADE
);

