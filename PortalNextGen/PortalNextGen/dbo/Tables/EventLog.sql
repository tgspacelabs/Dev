CREATE TABLE [dbo].[EventLog] (
    [EventLogID]      INT            IDENTITY (1, 1) NOT NULL,
    [EventID]         BIGINT         NOT NULL,
    [PatientID]       INT            NOT NULL,
    [Type]            NVARCHAR (30)  NOT NULL,
    [EventDateTime]   DATETIME2 (7)  NOT NULL,
    [SequenceNumber]  INT            NOT NULL,
    [Client]          NVARCHAR (50)  NOT NULL,
    [Description]     NVARCHAR (300) NOT NULL,
    [Status]          INT            NOT NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_EventLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_EventLog_EventLogID] PRIMARY KEY CLUSTERED ([EventLogID] ASC),
    CONSTRAINT [FK_EventLog_Event_EventID] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Event] ([EventID]),
    CONSTRAINT [FK_EventLog_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [FK_EventLog_Event_EventID]
    ON [dbo].[EventLog]([EventID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_EventLog_Patient_PatientID]
    ON [dbo].[EventLog]([PatientID] ASC);

