﻿CREATE TABLE [dbo].[Gateway] (
    [GatewayID]                    INT            IDENTITY (1, 1) NOT NULL,
    [GatewayType]                  CHAR (4)       NOT NULL,
    [NetworkID]                    NVARCHAR (30)  NOT NULL,
    [HostName]                     NVARCHAR (80)  NOT NULL,
    [EnableSwitch]                 BIT            NOT NULL,
    [ReceivingApplication]         NVARCHAR (30)  NOT NULL,
    [SendingApplication]           NVARCHAR (30)  NOT NULL,
    [ReconnectSeconds]             INT            NOT NULL,
    [OrganizationID]               INT            NOT NULL,
    [SendSystemID]                 INT            NOT NULL,
    [results_usid]                 INT            NOT NULL,
    [SleepSeconds]                 INT            NOT NULL,
    [AddMonitorsSwitch]            BIT            NOT NULL,
    [AddPatientsSwitch]            BIT            NOT NULL,
    [AddResultsSwitch]             BIT            NOT NULL,
    [DebugLevel]                   INT            NOT NULL,
    [UnitOrganizationID]           INT            NOT NULL,
    [PatientIDType]                CHAR (4)       NOT NULL,
    [AutoAssignIDSwitch]           BIT            NOT NULL,
    [NewMedicalRecordNumberFormat] NVARCHAR (80)  NOT NULL,
    [AutoChannelAttachSwitch]      BIT            NOT NULL,
    [LiveVitalsSwitch]             BIT            NOT NULL,
    [LiveWaveformSize]             INT            NOT NULL,
    [DecnetNode]                   INT            NOT NULL,
    [NodeName]                     CHAR (5)       NOT NULL,
    [NodesExcluded]                NVARCHAR (255) NOT NULL,
    [NodesIncluded]                NVARCHAR (255) NOT NULL,
    [TimeMasterSwitch]             BIT            NOT NULL,
    [WaveformSize]                 INT            NOT NULL,
    [PrintEnabledSwitch]           BIT            NOT NULL,
    [AutoRecordAlarmSwitch]        BIT            NOT NULL,
    [CollectTwelveLeadSwitch]      BIT            NOT NULL,
    [PrintAutoRecordSwitch]        BIT            NOT NULL,
    [EncryptionStatus]             BIT            NOT NULL,
    [CreatedDateTime]              DATETIME2 (7)  CONSTRAINT [DF_Gateway_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Gateway_GatewayID] PRIMARY KEY CLUSTERED ([GatewayID] ASC),
    CONSTRAINT [FK_Gateway_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Gateway_GatewayID]
    ON [dbo].[Gateway]([GatewayID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Gateway_NetworkID]
    ON [dbo].[Gateway]([NetworkID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Gateway_Organization_OrganizationID]
    ON [dbo].[Gateway]([OrganizationID] ASC);

