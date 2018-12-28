CREATE TABLE [dbo].[UserSavedEvent] (
    [UserSavedEventID]      INT           IDENTITY (1, 1) NOT NULL,
    [PatientID]             INT           NOT NULL,
    [EventID]               BIGINT        NOT NULL,
    [OriginalPatientID]     INT           NULL,
    [InsertDateTime]        DATETIME2 (7) NOT NULL,
    [UserID]                INT           NOT NULL,
    [OriginalEventCategory] INT           NOT NULL,
    [OriginalEventType]     INT           NOT NULL,
    [StartDateTime]         DATETIME2 (7) NOT NULL,
    [CenterDateTime]        DATETIME2 (7) NULL,
    [Duration]              INT           NOT NULL,
    [Value1]                INT           NOT NULL,
    [Divisor1]              INT           NOT NULL,
    [Value2]                INT           NULL,
    [Divisor2]              INT           NULL,
    [PrintFormat]           INT           NOT NULL,
    [Title]                 NVARCHAR (50) NULL,
    [Type]                  NVARCHAR (50) NULL,
    [RateCalipers]          TINYINT       NOT NULL,
    [MeasureCalipers]       TINYINT       NOT NULL,
    [CaliperStartDateTime]  INT           NULL,
    [CaliperEndDateTime]    INT           NULL,
    [CaliperTop]            INT           NULL,
    [CaliperBottom]         INT           NULL,
    [CaliperTopWaveType]    INT           NULL,
    [CaliperBottomWaveType] INT           NULL,
    [AnnotateData]          TINYINT       NOT NULL,
    [NumberOfWaveforms]     INT           NOT NULL,
    [CreatedDateTime]       DATETIME2 (7) CONSTRAINT [DF_UserSavedEvent_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_UserSavedEvent_UserSavedEventID] PRIMARY KEY CLUSTERED ([UserSavedEventID] ASC),
    CONSTRAINT [FK_UserSavedEvent_Event_EventID] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Event] ([EventID]),
    CONSTRAINT [FK_UserSavedEvent_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserSavedEvent_PatientID_EventID_InsertDateTime_UserID]
    ON [dbo].[UserSavedEvent]([PatientID] ASC, [EventID] ASC, [InsertDateTime] ASC, [UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_UserSavedEvent_Patient_PatientID]
    ON [dbo].[UserSavedEvent]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_UserSavedEvent_Event_EventID]
    ON [dbo].[UserSavedEvent]([EventID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_UserSavedEvent_User_UserID]
    ON [dbo].[UserSavedEvent]([UserID] ASC);

