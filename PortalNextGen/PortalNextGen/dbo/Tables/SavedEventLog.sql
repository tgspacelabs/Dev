CREATE TABLE [dbo].[SavedEventLog] (
    [SavedEventLogID]     BIGINT        IDENTITY (0, 1) NOT NULL,
    [PatientID]           INT           NOT NULL,
    [OriginalPatientID]   INT           NULL,
    [EventID]             BIGINT        NOT NULL,
    [PrimaryChannel]      BIT           NOT NULL,
    [TimeTagType]         INT           NOT NULL,
    [LeadType]            INT           NOT NULL,
    [MonitorEventType]    INT           NOT NULL,
    [ArrhythmiaEventType] INT           NOT NULL,
    [start_ms]            INT           NOT NULL,
    [end_ms]              INT           NOT NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_SavedEventLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SavedEventLog_SavedEventLogID] PRIMARY KEY CLUSTERED ([SavedEventLogID] ASC),
    CONSTRAINT [FK_SavedEventLog_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_SavedEventLog_PatientID_EventID] FOREIGN KEY ([PatientID], [EventID]) REFERENCES [dbo].[PatientSavedEvent] ([PatientID], [EventID])
);


GO
CREATE NONCLUSTERED INDEX [IX_SavedEventLog_PatientID_EventID]
    ON [dbo].[SavedEventLog]([PatientID] ASC, [EventID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SavedEventLog_Patient_PatientID]
    ON [dbo].[SavedEventLog]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SavedEventLog_PatientID_EventID]
    ON [dbo].[SavedEventLog]([PatientID] ASC, [EventID] ASC);

