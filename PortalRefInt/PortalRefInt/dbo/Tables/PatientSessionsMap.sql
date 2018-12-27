CREATE TABLE [dbo].[PatientSessionsMap] (
    [PatientSessionId] BIGINT NOT NULL,
    [PatientId]        BIGINT NOT NULL,
    [Sequence]         BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_PatientSessionMap_PatientId_Sequence] PRIMARY KEY CLUSTERED ([PatientId] ASC, [Sequence] DESC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_PatientSessionsMap_PatientSessionId_Sequence]
    ON [dbo].[PatientSessionsMap]([PatientSessionId] ASC, [Sequence] DESC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PatientSessionsMap_PatientId_PatientSessionId]
    ON [dbo].[PatientSessionsMap]([PatientId] ASC, [PatientSessionId] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PatientSessionsMap';

