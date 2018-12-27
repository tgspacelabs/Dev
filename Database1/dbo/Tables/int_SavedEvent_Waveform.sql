CREATE TABLE [dbo].[int_SavedEvent_Waveform] (
    [patient_id]        UNIQUEIDENTIFIER NOT NULL,
    [orig_patient_id]   UNIQUEIDENTIFIER NULL,
    [event_id]          UNIQUEIDENTIFIER NOT NULL,
    [wave_index]        INT              NOT NULL,
    [waveform_category] INT              NOT NULL,
    [lead]              INT              NOT NULL,
    [resolution]        INT              NOT NULL,
    [height]            INT              NOT NULL,
    [waveform_type]     INT              NOT NULL,
    [visible]           TINYINT          NOT NULL,
    [channel_id]        UNIQUEIDENTIFIER NOT NULL,
    [scale]             FLOAT (53)       NOT NULL,
    [scale_type]        INT              NOT NULL,
    [scale_min]         INT              NOT NULL,
    [scale_max]         INT              NOT NULL,
    [scale_unit_type]   INT              NOT NULL,
    [duration]          INT              NOT NULL,
    [sample_rate]       INT              NOT NULL,
    [sample_count]      BIGINT           NOT NULL,
    [num_Ypoints]       INT              NOT NULL,
    [baseline]          INT              NOT NULL,
    [Ypoints_per_unit]  FLOAT (53)       NOT NULL,
    [waveform_data]     IMAGE            NULL,
    [num_timelogs]      INT              NOT NULL,
    [timelog_data]      IMAGE            NULL,
    [waveform_color]    VARCHAR (50)     NULL,
    CONSTRAINT [PK_int_SavedEvent_Waveform_patient_id_event_id_channel_id] PRIMARY KEY CLUSTERED ([patient_id] ASC, [event_id] ASC, [channel_id] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [int_SavedEvent_int_SavedEvent_Waveform] FOREIGN KEY ([patient_id], [event_id]) REFERENCES [dbo].[int_SavedEvent] ([patient_id], [event_id]) ON DELETE CASCADE
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains waveform data for a given saved event. It should have patient_id, event_id, and wave_index as PKs. The event_id column corresponds to the event_id column in the SavedEvent table. There can be several rows in this table for a given saved event (one for each waveform in the saved event).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_SavedEvent_Waveform';

