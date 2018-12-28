CREATE TABLE [dbo].[PrintJobEnhancedTelemetryAlarm] (
    [PrintJobEnhancedTelemetryAlarmID] INT            IDENTITY (1, 1) NOT NULL,
    [AlarmID]                          INT            NOT NULL,
    [PatientID]                        INT            NOT NULL,
    [TopicSessionID]                   INT            NOT NULL,
    [DeviceSessionID]                  INT            NOT NULL,
    [AlarmStartDateTime]               DATETIME2 (7)  NOT NULL,
    [AlarmEndDateTime]                 DATETIME2 (7)  NULL,
    [StrTitleLabel]                    NVARCHAR (250) NOT NULL,
    [FirstName]                        NVARCHAR (50)  NOT NULL,
    [LastName]                         NVARCHAR (50)  NOT NULL,
    [ID1]                              NVARCHAR (30)  NOT NULL,
    [ID2]                              NVARCHAR (30)  NOT NULL,
    [DateOfBirth]                      DATE           NOT NULL,
    [FacilityName]                     NVARCHAR (180) NOT NULL,
    [UnitName]                         NVARCHAR (180) NOT NULL,
    [MonitorName]                      NVARCHAR (255) NOT NULL,
    [StrMessage]                       NVARCHAR (250) NOT NULL,
    [StrLimitFormat]                   NVARCHAR (250) NOT NULL,
    [StrValueFormat]                   NVARCHAR (250) NOT NULL,
    [ViolatingValue]                   NVARCHAR (120) NOT NULL,
    [SettingViolated]                  NVARCHAR (120) NOT NULL,
    [RowLastUpdatedOn]                 SMALLDATETIME  NOT NULL,
    [CreatedDateTime]                  DATETIME2 (7)  CONSTRAINT [DF_PrintJobEnhancedTelemetryAlarm_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PrintJobEnhancedTelemetryAlarm_PrintJobEnhancedTelemetryAlarmID] PRIMARY KEY CLUSTERED ([PrintJobEnhancedTelemetryAlarmID] ASC),
    CONSTRAINT [FK_PrintJobEnhancedTelemetryAlarm_DeviceSession_DeviceSessionID] FOREIGN KEY ([DeviceSessionID]) REFERENCES [dbo].[DeviceSession] ([DeviceSessionID]),
    CONSTRAINT [FK_PrintJobEnhancedTelemetryAlarm_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_PrintJobEnhancedTelemetryAlarm_TopicSession_TopicSessionID] FOREIGN KEY ([TopicSessionID]) REFERENCES [dbo].[TopicSession] ([TopicSessionID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryAlarm_TopicSessionID_INCLUDES]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([TopicSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryAlarm_TopicSessionID_AlarmStartDateTime_AlarmEndDateTime]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([TopicSessionID] ASC, [AlarmStartDateTime] ASC, [AlarmEndDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryAlarm_PatientID_AlarmStartDateTime_DeviceSessionID_AlarmEndDateTime_INCLUDES]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([PatientID] ASC, [AlarmStartDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryAlarm_PatientID_AlarmStartTimeUTC_INCLUDES]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([PatientID] ASC, [AlarmStartDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryAlarm_DeviceSessionId_AlarmStartTimeUTC_AlarmEndTimeUTC_PatientID]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([DeviceSessionID] ASC, [AlarmStartDateTime] ASC, [AlarmEndDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryAlarm_DeviceSessionID_AlarmStartDateTime_AlarmEndDateTime]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([DeviceSessionID] ASC, [AlarmStartDateTime] ASC, [AlarmEndDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryAlarm_AlarmEndTimeUTC_RowLastUpdatedOn_AlarmID]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([AlarmEndDateTime] ASC, [RowLastUpdatedOn] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PrintJobEnhancedTelemetryAlarm_DeviceSession_DeviceSessionID]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([DeviceSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PrintJobEnhancedTelemetryAlarm_Patient_PatientID]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PrintJobEnhancedTelemetryAlarm_TopicSession_TopicSessionID]
    ON [dbo].[PrintJobEnhancedTelemetryAlarm]([TopicSessionID] ASC);

