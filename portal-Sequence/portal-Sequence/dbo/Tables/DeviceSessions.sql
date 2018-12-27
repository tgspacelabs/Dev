CREATE TABLE [dbo].[DeviceSessions] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [DeviceId]     UNIQUEIDENTIFIER NULL,
    [BeginTimeUTC] DATETIME         NULL,
    [EndTimeUTC]   DATETIME         NULL,
    CONSTRAINT [PK_DeviceSessions_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE CLUSTERED INDEX [CL_DeviceSessions_DeviceId]
    ON [dbo].[DeviceSessions]([DeviceId] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Device session', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DeviceSessions';

