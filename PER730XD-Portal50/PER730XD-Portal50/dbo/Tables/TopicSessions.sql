CREATE TABLE [dbo].[TopicSessions] (
    [Id]               UNIQUEIDENTIFIER NOT NULL,
    [TopicTypeId]      UNIQUEIDENTIFIER NULL,
    [TopicInstanceId]  UNIQUEIDENTIFIER NULL,
    [DeviceSessionId]  UNIQUEIDENTIFIER NULL,
    [PatientSessionId] UNIQUEIDENTIFIER NULL,
    [BeginTimeUTC]     DATETIME         NULL,
    [EndTimeUTC]       DATETIME         NULL,
    CONSTRAINT [PK_TopicSessions_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE CLUSTERED INDEX [idxc_TopicSessions_1]
    ON [dbo].[TopicSessions]([PatientSessionId] ASC, [BeginTimeUTC] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSessions_PatientSessionId]
    ON [dbo].[TopicSessions]([PatientSessionId] ASC, [Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSessions_TopicType]
    ON [dbo].[TopicSessions]([TopicTypeId] ASC);

