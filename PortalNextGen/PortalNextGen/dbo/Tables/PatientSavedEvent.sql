CREATE TABLE [dbo].[PatientSavedEvent] (
    [UserID]                INT            NOT NULL,
    [PatientID]             INT            NOT NULL,
    [EventID]               BIGINT         NOT NULL,
    [OriginalPatientID]     INT            NULL,
    [InsertDateTime]        DATETIME2 (7)  NOT NULL,
    [OriginalEventCategory] INT            NOT NULL,
    [OriginalEventType]     INT            NOT NULL,
    [StartDateTime]         DATETIME2 (7)  NOT NULL,
    [StartMilliseconds]     INT            NOT NULL,
    [CenterDateTime]        INT            NULL,
    [Duration]              INT            NOT NULL,
    [Value1]                FLOAT (53)     NOT NULL,
    [Value2]                FLOAT (53)     NULL,
    [PrintFormat]           INT            NOT NULL,
    [Title]                 NVARCHAR (50)  NULL,
    [Comment]               NVARCHAR (200) NULL,
    [AnnotateData]          TINYINT        NOT NULL,
    [BeatColor]             TINYINT        NOT NULL,
    [NumberOfWaveforms]     INT            NOT NULL,
    [SweepSpeed]            INT            NOT NULL,
    [MinutesPerPage]        INT            NOT NULL,
    [ThumbnailChannel]      INT            NULL,
    [CreatedDateTime]       DATETIME2 (7)  CONSTRAINT [DF_PatientSavedEvent_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientSavedEvent_PatientID_EventID] PRIMARY KEY CLUSTERED ([PatientID] ASC, [EventID] ASC),
    CONSTRAINT [FK_PatientSavedEvent_Event_EventID] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Event] ([EventID]),
    CONSTRAINT [FK_PatientSavedEvent_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PatientSavedEvent_InsertDateTime_PatientID_EventID]
    ON [dbo].[PatientSavedEvent]([InsertDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientSavedEvent_Patient_PatientID]
    ON [dbo].[PatientSavedEvent]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientSavedEvent_Event_EventID]
    ON [dbo].[PatientSavedEvent]([EventID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientSavedEvent_User_UserID]
    ON [dbo].[PatientSavedEvent]([UserID] ASC);

