CREATE TABLE [dbo].[DeviceSession] (
    [DeviceSessionID]    INT           NOT NULL,
    [EncounterID]        INT           NOT NULL,
    [MonitoringDeviceID] INT           NOT NULL,
    [BeginDateTime]      DATETIME2 (7) NOT NULL,
    [EndDateTime]        DATETIME2 (7) NULL,
    [CreatedDateTime]    DATETIME2 (7) CONSTRAINT [DF_DeviceSession_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_DeviceSession_DeviceSessionID] PRIMARY KEY CLUSTERED ([DeviceSessionID] ASC),
    CONSTRAINT [FK_DeviceSession_Encounter_EncounterID] FOREIGN KEY ([DeviceSessionID]) REFERENCES [dbo].[Encounter] ([EncounterID]),
    CONSTRAINT [FK_DeviceSession_MonitoringDevice_MonitoringDeviceID] FOREIGN KEY ([MonitoringDeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID])
);


GO
CREATE NONCLUSTERED INDEX [FK_DeviceSession_Encounter_EncounterID]
    ON [dbo].[DeviceSession]([DeviceSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_DeviceSession_MonitoringDevice_MonitoringDeviceID]
    ON [dbo].[DeviceSession]([MonitoringDeviceID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceSessions_EndTime]
    ON [dbo].[DeviceSession]([EndDateTime] ASC);

