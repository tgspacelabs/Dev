CREATE TABLE [dbo].[EventConfiguration] (
    [EventConfigurationID]       INT           IDENTITY (1, 1) NOT NULL,
    [AlarmNotificationMode]      INT           NOT NULL,
    [VitalsUpdateInterval]       INT           NOT NULL,
    [AlarmPollingInterval]       INT           NOT NULL,
    [PortNumber]                 INT           NOT NULL,
    [TrackAlarmExecution]        TINYINT       NULL,
    [TrackVitalsUpdateExecution] TINYINT       NULL,
    [CreatedDateTime]            DATETIME2 (7) CONSTRAINT [DF_EventConfiguration_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_EventConfiguration_EventConfigurationID] PRIMARY KEY CLUSTERED ([EventConfigurationID] ASC)
);

