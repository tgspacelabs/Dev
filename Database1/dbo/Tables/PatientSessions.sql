CREATE TABLE [dbo].[PatientSessions] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [BeginTimeUTC] DATETIME         NOT NULL,
    [EndTimeUTC]   DATETIME         NULL,
    [Sequence]     BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_PatientSessions_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PatientSessions';

