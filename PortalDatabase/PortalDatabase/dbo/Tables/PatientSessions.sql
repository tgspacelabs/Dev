CREATE TABLE [dbo].[PatientSessions] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [BeginTimeUTC] DATETIME         NOT NULL,
    [EndTimeUTC]   DATETIME         NULL,
    CONSTRAINT [PK_PatientSessions_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PatientSessions';

