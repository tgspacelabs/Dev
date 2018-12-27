CREATE TABLE [dbo].[DeviceSessions] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [DeviceId]     UNIQUEIDENTIFIER NULL,
    [BeginTimeUTC] DATETIME         NULL,
    [EndTimeUTC]   DATETIME         NULL,
    CONSTRAINT [PK_DeviceSessions_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE CLUSTERED INDEX [CL_DeviceSessions_DeviceId]
    ON [dbo].[DeviceSessions]([DeviceId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceSessions_EndTimeUTC]
    ON [dbo].[DeviceSessions]([EndTimeUTC] ASC);

