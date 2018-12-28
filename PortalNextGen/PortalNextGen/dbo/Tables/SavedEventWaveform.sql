CREATE TABLE [dbo].[SavedEventWaveform] (
    [PatientID]         INT             NOT NULL,
    [OriginalPatientID] INT             NULL,
    [EventID]           BIGINT          NOT NULL,
    [WaveformIndex]     INT             NOT NULL,
    [WaveformCategory]  INT             NOT NULL,
    [Lead]              INT             NOT NULL,
    [Resolution]        INT             NOT NULL,
    [Height]            INT             NOT NULL,
    [WaveformType]      INT             NOT NULL,
    [Visible]           TINYINT         NOT NULL,
    [ChannelID]         INT             NOT NULL,
    [Scale]             FLOAT (53)      NOT NULL,
    [ScaleType]         INT             NOT NULL,
    [ScaleMinimum]      INT             NOT NULL,
    [ScaleMaximum]      INT             NOT NULL,
    [ScaleUnitType]     INT             NOT NULL,
    [Duration]          INT             NOT NULL,
    [SampleRate]        INT             NOT NULL,
    [SampleCount]       INT             NOT NULL,
    [NumberOfYPoints]   INT             NOT NULL,
    [Baseline]          INT             NOT NULL,
    [YPointsPerUnit]    FLOAT (53)      NOT NULL,
    [WaveformData]      VARBINARY (MAX) NULL,
    [NumberOfTimeLogs]  INT             NOT NULL,
    [TimeLogData]       VARBINARY (MAX) NULL,
    [WaveformColor]     VARCHAR (50)    NULL,
    [CreatedDateTime]   DATETIME2 (7)   CONSTRAINT [DF_SavedEventWaveform_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SavedEventWaveform_PatientID_EventID_ChannelID] PRIMARY KEY CLUSTERED ([PatientID] ASC, [EventID] ASC, [ChannelID] ASC),
    CONSTRAINT [FK_SavedEventWaveform_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_SavedEventWaveform_PatientSavedEvent_PatientID_EventID] FOREIGN KEY ([PatientID], [EventID]) REFERENCES [dbo].[PatientSavedEvent] ([PatientID], [EventID])
);


GO
CREATE NONCLUSTERED INDEX [IX_SavedEventWaveform_PatientID_EventID]
    ON [dbo].[SavedEventWaveform]([PatientID] ASC, [EventID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SavedEventWaveform_Patient_PatientID]
    ON [dbo].[SavedEventWaveform]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SavedEventWaveform_PatientSavedEvent_PatientID_EventID]
    ON [dbo].[SavedEventWaveform]([EventID] ASC, [PatientID] ASC);

