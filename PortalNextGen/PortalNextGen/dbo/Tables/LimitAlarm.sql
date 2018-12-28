CREATE TABLE [dbo].[LimitAlarm] (
    [LimitAlarmID]        INT           IDENTITY (1, 1) NOT NULL,
    [SettingViolated]     VARCHAR (25)  NOT NULL,
    [ViolatingValue]      VARCHAR (25)  NOT NULL,
    [StartDateTime]       DATETIME2 (7) NOT NULL,
    [EndDateTime]         DATETIME2 (7) NULL,
    [StatusValue]         INT           NOT NULL,
    [DetectionTimestamp]  DATETIME2 (7) NOT NULL,
    [Acknowledged]        BIT           NOT NULL,
    [PriorityWeightValue] INT           NOT NULL,
    [AcquiredDateTime]    DATETIME2 (7) NOT NULL,
    [Leads]               INT           NOT NULL,
    [WaveformFeedTypeID]  INT           NOT NULL,
    [TopicSessionID]      INT           NOT NULL,
    [FeedTypeID]          INT           NOT NULL,
    [IDEnumValue]         INT           NOT NULL,
    [EnumGroupID]         INT           NOT NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_LimitAlarm_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_LimitAlarmsData_LimitAlarmID] PRIMARY KEY CLUSTERED ([LimitAlarmID] ASC),
    CONSTRAINT [FK_LimitAlarm_FeedType_FeedTypeID] FOREIGN KEY ([FeedTypeID]) REFERENCES [dbo].[FeedType] ([FeedTypeID]),
    CONSTRAINT [FK_LimitAlarm_TopicSession_TopicSessionID] FOREIGN KEY ([TopicSessionID]) REFERENCES [dbo].[TopicSession] ([TopicSessionID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LimitAlarmsData_TopicSessionID_StartDateTime_EndDateTime_PriorityWeightValueIDEnumValue]
    ON [dbo].[LimitAlarm]([TopicSessionID] ASC, [StartDateTime] ASC, [EndDateTime] ASC, [PriorityWeightValue] ASC, [IDEnumValue] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LimitAlarmsData_TopicSessionID_StartDateTime_INCLUDES]
    ON [dbo].[LimitAlarm]([TopicSessionID] ASC, [StartDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LimitAlarmsData_EndDateTime_TopicSessionID_LimitAlarmID]
    ON [dbo].[LimitAlarm]([EndDateTime] ASC, [TopicSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LimitAlarmsData_StartDateTime_AlarmId_SettingViolated_ViolatingValue_EndDateTime_PriorityWeightValue_INCLUDES]
    ON [dbo].[LimitAlarm]([StartDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LimitAlarmsData_StartDateTime]
    ON [dbo].[LimitAlarm]([StartDateTime] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_LimitAlarmsData_AlarmID]
    ON [dbo].[LimitAlarm]([LimitAlarmID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_LimitAlarm_FeedType_FeedTypeID]
    ON [dbo].[LimitAlarm]([FeedTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_LimitAlarm_TopicSession_TopicSessionID]
    ON [dbo].[LimitAlarm]([TopicSessionID] ASC);

