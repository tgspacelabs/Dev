CREATE TABLE [dbo].[PacerSpikeLog] (
    [PacerSpikeLogID] INT             IDENTITY (1, 1) NOT NULL,
    [UserID]          INT             NOT NULL,
    [PatientID]       INT             NOT NULL,
    [SampleRate]      SMALLINT        NOT NULL,
    [StartDateTime]   DATETIME2 (7)   NOT NULL,
    [NumberOfSpikes]  INT             NOT NULL,
    [SpikeData]       VARBINARY (MAX) NOT NULL,
    [AnalysisTimeID]  INT             NOT NULL,
    [CreatedDateTime] DATETIME2 (7)   CONSTRAINT [DF_PacerSpikeLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PacerSpikeLog_PacerSpikeLogID] PRIMARY KEY CLUSTERED ([PacerSpikeLogID] ASC),
    CONSTRAINT [FK_PacerSpikeLog_AnalysisTime_AnalysisTimeID] FOREIGN KEY ([AnalysisTimeID]) REFERENCES [dbo].[AnalysisTime] ([AnalysisTimeID]),
    CONSTRAINT [FK_PacerSpikeLog_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PacerSpikeLog_UserID_PatientID_SampleRate]
    ON [dbo].[PacerSpikeLog]([UserID] ASC, [PatientID] ASC, [SampleRate] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PacerSpikeLog_AnalysisTime_AnalysisTimeID]
    ON [dbo].[PacerSpikeLog]([AnalysisTimeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PacerSpikeLog_Patient_PatientID]
    ON [dbo].[PacerSpikeLog]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PacerSpikeLog_User_UserID]
    ON [dbo].[PacerSpikeLog]([UserID] ASC);

