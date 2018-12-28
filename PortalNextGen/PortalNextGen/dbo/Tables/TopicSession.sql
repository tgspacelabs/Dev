CREATE TABLE [dbo].[TopicSession] (
    [TopicSessionID]   INT           IDENTITY (1, 1) NOT NULL,
    [TopicTypeID]      INT           NOT NULL,
    [TopicInstanceID]  INT           NOT NULL,
    [DeviceSessionID]  INT           NOT NULL,
    [PatientSessionID] INT           NOT NULL,
    [BeginDateTime]    DATETIME2 (7) NOT NULL,
    [EndDateTime]      DATETIME2 (7) NOT NULL,
    [CreatedDateTime]  DATETIME2 (7) CONSTRAINT [DF_TopicSession_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TopicSessions_TopicSessionID] PRIMARY KEY CLUSTERED ([TopicSessionID] ASC),
    CONSTRAINT [FK_TopicSession_DeviceSession_DeviceSessionID] FOREIGN KEY ([DeviceSessionID]) REFERENCES [dbo].[DeviceSession] ([DeviceSessionID]),
    CONSTRAINT [FK_TopicSession_TopicType_TopicTypeID] FOREIGN KEY ([TopicTypeID]) REFERENCES [dbo].[TopicType] ([TopicTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSessionID_TopicInstanceID]
    ON [dbo].[TopicSession]([TopicSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSession_TopicInstanceID_EndTimeUTCID_PatientSessionID]
    ON [dbo].[TopicSession]([TopicInstanceID] ASC, [EndDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSession_PatientSessionIDID_DeviceSessionID]
    ON [dbo].[TopicSession]([PatientSessionID] ASC, [TopicSessionID] ASC, [DeviceSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSession_DeviceSessionIDID_PatientSessionID]
    ON [dbo].[TopicSession]([DeviceSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicsSession_DeviceSessionID_EndTimeUTC_TopicInstanceID_PatientSessionID_BeginDateTime]
    ON [dbo].[TopicSession]([DeviceSessionID] ASC, [EndDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSession_DeviceSessionIDID_BeginDateTime]
    ON [dbo].[TopicSession]([DeviceSessionID] ASC, [TopicSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSession_DeviceSessionID_BeginDateTimeID_PatientSessionID]
    ON [dbo].[TopicSession]([DeviceSessionID] ASC, [BeginDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSession_DeviceSessionID_BeginDateTimeID]
    ON [dbo].[TopicSession]([DeviceSessionID] ASC, [BeginDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSession_BeginDateTime_EndDateTime]
    ON [dbo].[TopicSession]([BeginDateTime] ASC, [EndDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TopicSession_DeviceSession_DeviceSessionID]
    ON [dbo].[TopicSession]([DeviceSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TopicSession_TopicType_TopicTypeID]
    ON [dbo].[TopicSession]([TopicTypeID] ASC);

