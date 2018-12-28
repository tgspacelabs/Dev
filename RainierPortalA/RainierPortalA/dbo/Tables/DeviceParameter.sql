CREATE TABLE [dbo].[DeviceParameter] (
    [DeviceParameterID] BIGINT        IDENTITY (-9223372036854775808, 1) NOT NULL,
    [DeviceID]          BIGINT        NOT NULL,
    [ParameterID]       BIGINT        NOT NULL,
    [CreatedDateTime]   DATETIME2 (7) CONSTRAINT [DF_DeviceParameter_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_DeviceParameter_DeviceParameterID] PRIMARY KEY CLUSTERED ([DeviceParameterID] ASC),
    CONSTRAINT [FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID] FOREIGN KEY ([DeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID]),
    CONSTRAINT [FK_DeviceParameter_Parameter_ParameterID] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[Parameter] ([ParameterID])
);


GO
CREATE NONCLUSTERED INDEX [FK_DeviceParameter_Parameter_ParameterID]
    ON [dbo].[DeviceParameter]([ParameterID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_DeviceParameter_MonitoringDevice_MonitoringDeviceID]
    ON [dbo].[DeviceParameter]([DeviceID] ASC);

