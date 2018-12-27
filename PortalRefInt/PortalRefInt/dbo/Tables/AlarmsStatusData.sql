CREATE TABLE [dbo].[AlarmsStatusData] (
    [Id]                  BIGINT NOT NULL,
    [AlarmId]             BIGINT NOT NULL,
    [StatusTimeout]       TINYINT          NULL,
    [StatusValue]         INT              NOT NULL,
    [AcquiredDateTimeUTC] DATETIME         NOT NULL,
    [Leads]               INT              NOT NULL,
    [WaveformFeedTypeId]  BIGINT NOT NULL,
    [TopicSessionId]      BIGINT NOT NULL,
    [FeedTypeId]          BIGINT NOT NULL,
    [IDEnumValue]         INT              NOT NULL,
    [EnumGroupId]         BIGINT NOT NULL,
    CONSTRAINT [PK_AlarmsStatusData_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_AlarmsStatusData_int_print_job_et_alarm_AlarmId] FOREIGN KEY ([AlarmId]) REFERENCES [dbo].[int_print_job_et_alarm] ([AlarmId]),
    CONSTRAINT [FK_AlarmsStatusData_RemovedAlarms_AlarmId] FOREIGN KEY ([AlarmId]) REFERENCES [dbo].[RemovedAlarms] ([AlarmId]),
    CONSTRAINT [FK_AlarmsStatusData_TopicFeedTypes_FeedTypeId] FOREIGN KEY ([FeedTypeId]) REFERENCES [dbo].[TopicFeedTypes] ([FeedTypeId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AlarmsStatusData';

