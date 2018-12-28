CREATE TABLE [dbo].[PatientMonitor] (
    [PatientMonitorID]       INT            IDENTITY (1, 1) NOT NULL,
    [PatientID]              INT            NOT NULL,
    [OriginalPatientID]      INT            NOT NULL,
    [MonitorID]              INT            NOT NULL,
    [MonitorInterval]        INT            NOT NULL,
    [PollingType]            CHAR (1)       NOT NULL,
    [MonitorConnectDateTime] DATETIME2 (7)  NOT NULL,
    [MonitorConnectNumber]   INT            NOT NULL,
    [DisableSwitch]          TINYINT        NOT NULL,
    [LastPollingDateTime]    DATETIME2 (7)  NOT NULL,
    [LastResultDateTime]     DATETIME2 (7)  NOT NULL,
    [LastEpisodicDateTime]   DATETIME2 (7)  NOT NULL,
    [PollStartDateTime]      DATETIME2 (7)  NOT NULL,
    [PollEndDateTime]        DATETIME2 (7)  NOT NULL,
    [LastOutboundDateTime]   DATETIME2 (7)  NOT NULL,
    [MonitorStatus]          CHAR (3)       NOT NULL,
    [MonitorError]           NVARCHAR (255) NOT NULL,
    [EncounterID]            INT            NOT NULL,
    [LiveUntilDateTime]      DATETIME2 (7)  NOT NULL,
    [ActiveSwitch]           BIT            NOT NULL,
    [CreatedDateTime]        DATETIME2 (7)  CONSTRAINT [DF_PatientMonitor_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientMonitor_PatientMonitorID] PRIMARY KEY CLUSTERED ([PatientMonitorID] ASC),
    CONSTRAINT [FK_PatientMonitor_Monitor_MonitorID] FOREIGN KEY ([MonitorID]) REFERENCES [dbo].[Monitor] ([MonitorID]),
    CONSTRAINT [FK_PatientMonitor_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PatientMonitor_PatientID_MonitorID_MonitorConnectDateTime]
    ON [dbo].[PatientMonitor]([PatientID] ASC, [MonitorID] ASC, [MonitorConnectDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PatientMonitor_MonitorID_EncounterID_LastResultDateTime_PatientMonitorID]
    ON [dbo].[PatientMonitor]([MonitorID] ASC, [EncounterID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PatientMonitor_MonitorConnectDateTime_EncounterID]
    ON [dbo].[PatientMonitor]([MonitorConnectDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PatientMonitor_EncounterID_MonitorID_LastPollingDateTime_LastResultDateTime_PatientMonitorID]
    ON [dbo].[PatientMonitor]([EncounterID] ASC, [MonitorID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientMonitor_Monitor_MonitorID]
    ON [dbo].[PatientMonitor]([MonitorID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientMonitor_Patient_PatientID]
    ON [dbo].[PatientMonitor]([PatientID] ASC);

