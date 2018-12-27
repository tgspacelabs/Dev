CREATE TABLE [dbo].[int_savedevent_calipers] (
    [patient_id]           UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id]      UNIQUEIDENTIFIER NULL,
    [event_id]             UNIQUEIDENTIFIER NOT NULL,
    [channel_type]         INT              NOT NULL,
    [caliper_type]         INT              NOT NULL,
    [calipers_orientation] NCHAR (50)       NOT NULL,
    [caliper_text]         NVARCHAR (200)   NULL,
    [caliper_start_ms]     BIGINT           NOT NULL,
    [caliper_end_ms]       BIGINT           NOT NULL,
    [caliper_top]          INT              NOT NULL,
    [caliper_bottom]       INT              NOT NULL,
    [first_caliper_index]  INT              NULL,
    [second_caliper_index] INT              NULL,
    CONSTRAINT [PK_int_savedevent_calipers] PRIMARY KEY CLUSTERED ([patient_id] ASC, [event_id] ASC, [channel_type] ASC, [caliper_type] ASC),
    CONSTRAINT [int_SavedEvent_int_savedevent_calipers] FOREIGN KEY ([patient_id], [event_id]) REFERENCES [dbo].[int_SavedEvent] ([patient_id], [event_id]) ON DELETE CASCADE
);

