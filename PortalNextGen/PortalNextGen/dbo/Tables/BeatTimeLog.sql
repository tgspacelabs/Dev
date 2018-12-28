CREATE TABLE [dbo].[BeatTimeLog] (
    [BeatTimeLogID]   INT             IDENTITY (1, 1) NOT NULL,
    [UserID]          INT             NOT NULL,
    [PatientID]       INT             NOT NULL,
    [StartDateTime]   DATETIME2 (7)   NOT NULL,
    [NumberBeats]     INT             NOT NULL,
    [SampleRate]      SMALLINT        NOT NULL,
    [BeatData]        VARBINARY (MAX) NULL,
    [AnalysisTimeID]  INT             NOT NULL,
    [CreatedDateTime] DATETIME2 (7)   CONSTRAINT [DF_BeatTimeLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_BeatTimeLog_BeatTimeLogID] PRIMARY KEY CLUSTERED ([BeatTimeLogID] ASC),
    CONSTRAINT [FK_BeatTimeLog_AnalysisTime_AnalysisTimeID] FOREIGN KEY ([AnalysisTimeID]) REFERENCES [dbo].[AnalysisTime] ([AnalysisTimeID]),
    CONSTRAINT [FK_BeatTimeLog_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_BeatTimeLog_UserID_PatientID_SampleRate]
    ON [dbo].[BeatTimeLog]([UserID] ASC, [PatientID] ASC, [SampleRate] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_BeatTimeLog_AnalysisTime_AnalysisTimeID]
    ON [dbo].[BeatTimeLog]([AnalysisTimeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_BeatTimeLog_Patient_PatientID]
    ON [dbo].[BeatTimeLog]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_BeatTimeLog_User_UserID]
    ON [dbo].[BeatTimeLog]([UserID] ASC);

