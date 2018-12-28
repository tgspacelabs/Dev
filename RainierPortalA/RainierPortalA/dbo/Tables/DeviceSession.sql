CREATE TABLE [dbo].[DeviceSession] (
    [DeviceSessionID]    BIGINT        NOT NULL,
    [MonitoringDeviceID] BIGINT        NOT NULL,
    [EncounterID]        INT           NOT NULL,
    [BeginDateTime]      DATETIME2 (7) NOT NULL,
    [EndDateTime]        DATETIME2 (7) NULL,
    [CreatedDateTime]    DATETIME2 (7) CONSTRAINT [DF_DeviceSession_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_DeviceSession_DeviceSessionID] PRIMARY KEY CLUSTERED ([DeviceSessionID] ASC),
    CONSTRAINT [FK_DeviceSession_Encounter_EncounterID] FOREIGN KEY ([EncounterID]) REFERENCES [dbo].[Encounter] ([EncounterID])
);


GO
CREATE NONCLUSTERED INDEX [FK_DeviceSession_Encounter_EncounterID]
    ON [dbo].[DeviceSession]([EncounterID] ASC);

