CREATE TABLE [dbo].[AcquistionModule] (
    [AcquistionModuleID] INT           NOT NULL,
    [MonitoringDeviceID] BIGINT        NOT NULL,
    [CreatedDateTime]    DATETIME2 (7) CONSTRAINT [DF__Acquistio__Creat__45F365D3] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AcquistionModule_AcquistionModuleID] PRIMARY KEY CLUSTERED ([AcquistionModuleID] ASC),
    CONSTRAINT [FK_AcquistionModule_MonitoringDevice_MonitoringDeviceID] FOREIGN KEY ([MonitoringDeviceID]) REFERENCES [dbo].[MonitoringDevice] ([MonitoringDeviceID])
);


GO
CREATE NONCLUSTERED INDEX [FK_AcquistionModule_MonitoringDevice_MonitoringDeviceID]
    ON [dbo].[AcquistionModule]([MonitoringDeviceID] ASC);

