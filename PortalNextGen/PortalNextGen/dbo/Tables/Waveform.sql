CREATE TABLE [dbo].[Waveform] (
    [WaveformID]      BIGINT          NOT NULL,
    [ParameterID]     INT             NOT NULL,
    [SampleCount]     INT             NOT NULL,
    [TypeName]        VARCHAR (50)    NOT NULL,
    [TypeID]          INT             NOT NULL,
    [Samples]         VARBINARY (MAX) NOT NULL,
    [Compressed]      BIT             NOT NULL,
    [TopicSessionID]  INT             NOT NULL,
    [StartDateTime]   DATETIME2 (7)   NOT NULL,
    [EndDateTime]     DATETIME2 (7)   NOT NULL,
    [CreatedDateTime] DATETIME2 (7)   CONSTRAINT [DF_Waveform_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Waveform_WaveformID] PRIMARY KEY CLUSTERED ([WaveformID] ASC),
    CONSTRAINT [FK_Waveform_Parameter_ParameterID] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID]),
    CONSTRAINT [FK_Waveform_TopicSession_TopicSessionID] FOREIGN KEY ([TopicSessionID]) REFERENCES [dbo].[TopicSession] ([TopicSessionID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Waveform_Parameter_ParameterID]
    ON [dbo].[Waveform]([ParameterID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Waveform_EndDateTime_WaveformID]
    ON [dbo].[Waveform]([EndDateTime] ASC, [WaveformID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Waveform_TopicSessionID_StartDateTime_EndDateTime_TypeID_Samples]
    ON [dbo].[Waveform]([TopicSessionID] ASC, [StartDateTime] ASC, [EndDateTime] ASC, [TypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Waveform_TopicSession_TopicSessionID]
    ON [dbo].[Waveform]([TopicSessionID] ASC);

