CREATE TABLE [dbo].[AnalysisEvent] (
    [AnalysisEventID] INT             IDENTITY (1, 1) NOT NULL,
    [PatientID]       INT             NOT NULL,
    [UserID]          INT             NOT NULL,
    [Type]            INT             NOT NULL,
    [NumberOfEvents]  INT             NOT NULL,
    [SampleRate]      SMALLINT        NOT NULL,
    [EventData]       VARBINARY (MAX) NULL,
    [AnalysisTimeID]  INT             NOT NULL,
    [CreatedDateTime] DATETIME2 (7)   CONSTRAINT [DF_AnalysisEvent_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AnalysisEvent_AnalysisEventID] PRIMARY KEY CLUSTERED ([AnalysisEventID] ASC),
    CONSTRAINT [FK_AnalysisEvent_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_AnalysisEvents_AnalysisTime_AnalysisTimeID] FOREIGN KEY ([AnalysisTimeID]) REFERENCES [dbo].[AnalysisTime] ([AnalysisTimeID])
);


GO
CREATE NONCLUSTERED INDEX [FK_AnalysisEvent_Patient_PatientID]
    ON [dbo].[AnalysisEvent]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_AnalysisEvent_User_UserID]
    ON [dbo].[AnalysisEvent]([UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_AnalysisEvents_AnalysisTime_AnalysisTimeID]
    ON [dbo].[AnalysisEvent]([AnalysisTimeID] ASC);

