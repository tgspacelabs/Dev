CREATE TABLE [dbo].[PrintJobEnhancedTelemetryWaveform] (
    [PrintJobEnhancedTelemetryWaveformID] INT             NOT NULL,
    [DeviceSessionID]                     INT             NOT NULL,
    [StartDateTime]                       DATETIME2 (7)   NOT NULL,
    [EndDateTime]                         DATETIME2 (7)   NOT NULL,
    [SampleRate]                          INT             NOT NULL,
    [WaveformData]                        VARBINARY (MAX) NOT NULL,
    [ChannelCode]                         INT             NOT NULL,
    [CdiLabel]                            VARCHAR (255)   NOT NULL,
    [CreatedDateTime]                     DATETIME2 (7)   CONSTRAINT [DF_PrintJobEnhancedTelemetryWaveform_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PrintJobEnhancedTelemetryWaveform_PrintJobEnhancedTelemetryWaveformID] PRIMARY KEY CLUSTERED ([PrintJobEnhancedTelemetryWaveformID] ASC),
    CONSTRAINT [FK_PrintJobEnhancedTelemetryWaveform_DeviceSession_DeviceSessionID] FOREIGN KEY ([DeviceSessionID]) REFERENCES [dbo].[DeviceSession] ([DeviceSessionID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryWaveform_DeviceSessionID_StartDateTime_EndDateTime_ChannelCode]
    ON [dbo].[PrintJobEnhancedTelemetryWaveform]([DeviceSessionID] ASC, [StartDateTime] ASC, [EndDateTime] ASC, [ChannelCode] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PrintJobEnhancedTelemetryWaveform_DeviceSession_DeviceSessionID]
    ON [dbo].[PrintJobEnhancedTelemetryWaveform]([DeviceSessionID] ASC);

