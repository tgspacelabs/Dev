CREATE TABLE [dbo].[AlarmWaveform] (
    [AlarmWaveformID] INT           IDENTITY (1, 1) NOT NULL,
    [AlarmID]         INT           NOT NULL,
    [Retrieved]       TINYINT       NOT NULL,
    [SequenceNumber]  INT           NOT NULL,
    [WaveformData]    VARCHAR (MAX) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_AlarmWaveform_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AlarmWaveform_AlarmWaveformID] PRIMARY KEY CLUSTERED ([AlarmWaveformID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AlarmWaveform_AlarmID_SequenceNumber]
    ON [dbo].[AlarmWaveform]([AlarmID] ASC, [SequenceNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_AlarmWaveform_CreatedDateTime]
    ON [dbo].[AlarmWaveform]([CreatedDateTime] ASC);

