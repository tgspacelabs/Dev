CREATE TABLE [dbo].[EnhancedTelemetryTemporarySettings] (
    [EnhancedTelemetryTemporarySettingsID] INT            IDENTITY (1, 1) NOT NULL,
    [GatewayID]                            INT            NOT NULL,
    [GatewayType]                          NVARCHAR (10)  NOT NULL,
    [FarmName]                             NVARCHAR (5)   NOT NULL,
    [Network]                              NVARCHAR (30)  NOT NULL,
    [ETDoNotStoreWaveforms]                TINYINT        NOT NULL,
    [IncludeTransmitterChannels]           NVARCHAR (255) NOT NULL,
    [ExcludeTransmitterChannels]           NVARCHAR (255) NOT NULL,
    [ETPrintAlarms]                        TINYINT        NOT NULL,
    [CreatedDateTime]                      DATETIME2 (7)  CONSTRAINT [DF_EnhancedTelemetryTemporarySettings_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_EnhancedTelemetryTemporarySettings_EnhancedTelemetryTemporarySettingsID] PRIMARY KEY CLUSTERED ([EnhancedTelemetryTemporarySettingsID] ASC)
);

