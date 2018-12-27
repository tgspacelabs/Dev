CREATE TABLE [dbo].[DeviceSessions] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [DeviceId]     UNIQUEIDENTIFIER NULL,
    [BeginTimeUTC] DATETIME         NULL,
    [EndTimeUTC]   DATETIME         NULL,
    CONSTRAINT [PK_DeviceSessions_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceSessions_EndTimeUTC]
    ON [dbo].[DeviceSessions]([EndTimeUTC] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceSessions_DeviceId_BeginTimeUTC]
    ON [dbo].[DeviceSessions]([DeviceId] ASC, [BeginTimeUTC] DESC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DeviceSessions';

