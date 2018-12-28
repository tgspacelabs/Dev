CREATE TABLE [dbo].[MonitoringDevice] (
    [MonitoringDeviceID] INT           NOT NULL,
    [Name]               VARCHAR (50)  NOT NULL,
    [Description]        VARCHAR (50)  NOT NULL,
    [Room]               VARCHAR (12)  NOT NULL,
    [CreatedDateTime]    DATETIME2 (7) CONSTRAINT [DF_MonitoringDevice_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MonitoringDevice_MonitoringDeviceID] PRIMARY KEY CLUSTERED ([MonitoringDeviceID] ASC)
);

