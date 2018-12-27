CREATE TABLE [dbo].[PatientSessions] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [BeginTimeUTC] DATETIME         NOT NULL,
    [EndTimeUTC]   DATETIME         NULL,
    CONSTRAINT [PK_PatientSessions_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);

