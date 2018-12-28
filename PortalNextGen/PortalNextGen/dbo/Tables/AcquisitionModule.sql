CREATE TABLE [dbo].[AcquisitionModule] (
    [AcquisitionModuleID] INT           NOT NULL,
    [Name]                VARCHAR (50)  NOT NULL,
    [Description]         VARCHAR (50)  NOT NULL,
    [MonitoringDeviceID]  INT           NOT NULL,
    [ParameterID]         INT           NOT NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_AcquisitionModule_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AcquisitionModule_AcquisitionModuleID] PRIMARY KEY CLUSTERED ([AcquisitionModuleID] ASC),
    CONSTRAINT [FK_AcquisitionModule_MonitoringDevice_MonitoringDeviceID] FOREIGN KEY ([MonitoringDeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID])
);


GO
CREATE NONCLUSTERED INDEX [FK_AcquisitionModule_MonitoringDevice_MonitoringDeviceID]
    ON [dbo].[AcquisitionModule]([MonitoringDeviceID] ASC);

