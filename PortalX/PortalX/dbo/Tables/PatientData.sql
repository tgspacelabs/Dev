CREATE TABLE [dbo].[PatientData] (
    [Id]               UNIQUEIDENTIFIER NOT NULL,
    [PatientSessionId] UNIQUEIDENTIFIER NOT NULL,
    [DeviceSessionId]  UNIQUEIDENTIFIER NULL,
    [LastName]         NVARCHAR (50)    NULL,
    [MiddleName]       NVARCHAR (50)    NULL,
    [FirstName]        NVARCHAR (50)    NULL,
    [FullName]         NVARCHAR (150)   NULL,
    [Gender]           NVARCHAR (50)    NULL,
    [ID1]              NVARCHAR (30)    NULL,
    [ID2]              NVARCHAR (30)    NULL,
    [DOB]              NVARCHAR (50)    NULL,
    [Weight]           NVARCHAR (25)    NULL,
    [WeightUOM]        NVARCHAR (25)    NULL,
    [Height]           NVARCHAR (25)    NULL,
    [HeightUOM]        NVARCHAR (25)    NULL,
    [BSA]              NVARCHAR (25)    NULL,
    [Location]         NVARCHAR (50)    NULL,
    [PatientType]      NVARCHAR (150)   NULL,
    [TimestampUTC]     DATETIME         NOT NULL,
    CONSTRAINT [PK_PatientData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_PatientData_ID1_TimestampUTC_PatientSessionId]
    ON [dbo].[PatientData]([ID1] ASC, [TimestampUTC] DESC, [PatientSessionId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PatientData_PatientSessionId_TimestampUTC_ID1]
    ON [dbo].[PatientData]([PatientSessionId] ASC, [TimestampUTC] DESC)
    INCLUDE([ID1]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_PatientData_DeviceSessionId_INCLUDES]
    ON [dbo].[PatientData]([DeviceSessionId] ASC)
    INCLUDE([PatientSessionId], [TimestampUTC]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PatientData';

