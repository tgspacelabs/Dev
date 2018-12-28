CREATE TABLE [dbo].[PatientChannel] (
    [PatientChannelID]  INT           IDENTITY (1, 1) NOT NULL,
    [PatientMonitorID]  INT           NOT NULL,
    [PatientID]         INT           NOT NULL,
    [OriginalPatientID] INT           NULL,
    [MonitorID]         INT           NOT NULL,
    [ModuleNumber]      INT           NOT NULL,
    [ChannelNumber]     INT           NOT NULL,
    [ChannelTypeID]     INT           NOT NULL,
    [CollectionSwitch]  BIT           NOT NULL,
    [ActiveSwitch]      BIT           NOT NULL,
    [CreatedDateTime]   DATETIME2 (7) CONSTRAINT [DF_PatientChannel_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientChannel_PatientChannelID] PRIMARY KEY CLUSTERED ([PatientChannelID] ASC),
    CONSTRAINT [FK_PatientChannel_ChannelType_ChannelTypeID] FOREIGN KEY ([ChannelTypeID]) REFERENCES [dbo].[ChannelType] ([ChannelTypeID]),
    CONSTRAINT [FK_PatientChannel_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PatientChannel_PatientChannelID_ChannelTypeID]
    ON [dbo].[PatientChannel]([PatientChannelID] ASC, [ChannelTypeID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PatientChannel_PatientID_MonitorID_ModuleNumber_ChannelNumber_PatientMonitorID_ChannelTypeID]
    ON [dbo].[PatientChannel]([PatientID] ASC, [MonitorID] ASC, [ModuleNumber] ASC, [ChannelNumber] ASC, [PatientMonitorID] ASC, [ChannelTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientChannel_ChannelType_ChannelTypeID]
    ON [dbo].[PatientChannel]([ChannelTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PatientChannel_Patient_PatientID]
    ON [dbo].[PatientChannel]([PatientID] ASC);

