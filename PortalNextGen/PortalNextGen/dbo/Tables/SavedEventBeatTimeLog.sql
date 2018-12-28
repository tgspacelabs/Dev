CREATE TABLE [dbo].[SavedEventBeatTimeLog] (
    [SavedEventBeatTimeLogID] INT             IDENTITY (1, 1) NOT NULL,
    [PatientID]               INT             NOT NULL,
    [EventID]                 BIGINT          NOT NULL,
    [PatientStartDateTime]    DATETIME2 (7)   NOT NULL,
    [StartDateTime]           DATETIME2 (7)   NOT NULL,
    [NumberOfBeats]           INT             NOT NULL,
    [SampleRate]              SMALLINT        NOT NULL,
    [BeatData]                VARBINARY (MAX) NOT NULL,
    [CreatedDateTime]         DATETIME2 (7)   CONSTRAINT [DF_SavedEventBeatTimeLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SavedEventBeatTimeLog_SavedEventBeatTimeLogID] PRIMARY KEY CLUSTERED ([SavedEventBeatTimeLogID] ASC),
    CONSTRAINT [FK_SavedEventBeatTimeLog_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_SavedEventBeatTimeLog_PatientSavedEvent_PatientID_EventID] FOREIGN KEY ([PatientID], [EventID]) REFERENCES [dbo].[PatientSavedEvent] ([PatientID], [EventID])
);


GO
CREATE NONCLUSTERED INDEX [IX_SavedEventBeatTimeLog_PatientID_EventID]
    ON [dbo].[SavedEventBeatTimeLog]([PatientID] ASC, [EventID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SavedEventBeatTimeLog_Patient_PatientID]
    ON [dbo].[SavedEventBeatTimeLog]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SavedEventBeatTimeLog_PatientSavedEvent_PatientID_EventID]
    ON [dbo].[SavedEventBeatTimeLog]([PatientID] ASC, [EventID] ASC);

