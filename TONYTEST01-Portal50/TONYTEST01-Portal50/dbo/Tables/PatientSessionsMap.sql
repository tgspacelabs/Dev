CREATE TABLE [dbo].[PatientSessionsMap] (
    [PatientSessionId] UNIQUEIDENTIFIER NOT NULL,
    [PatientId]        UNIQUEIDENTIFIER NOT NULL,
    [Sequence]         BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_PatientSessionMap_PatientId_Sequence] PRIMARY KEY CLUSTERED ([PatientId] ASC, [Sequence] DESC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PatientSessionsMap_PatientSessionId_Sequence]
    ON [dbo].[PatientSessionsMap]([PatientSessionId] ASC, [Sequence] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_PatientSessionsMap_PatientId_PatientSessionId]
    ON [dbo].[PatientSessionsMap]([PatientId] ASC, [PatientSessionId] ASC);

