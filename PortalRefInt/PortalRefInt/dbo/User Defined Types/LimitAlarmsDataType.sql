CREATE TYPE [dbo].[LimitAlarmsDataType] AS TABLE (
    [AlarmId]             BIGINT NOT NULL,
    [SettingViolated]     VARCHAR (25)     NOT NULL,
    [ViolatingValue]      VARCHAR (25)     NOT NULL,
    [StartDateTime]       DATETIME         NULL,
    [EndDateTime]         DATETIME         NULL,
    [StatusValue]         INT              NOT NULL,
    [DetectionTimestamp]  DATETIME         NULL,
    [Acknowledged]        BIT              NOT NULL,
    [PriorityWeightValue] INT              NOT NULL,
    [AcquiredDateTimeUTC] DATETIME         NOT NULL,
    [Leads]               INT              NOT NULL,
    [WaveformFeedTypeId]  BIGINT NOT NULL,
    [TopicSessionId]      BIGINT NOT NULL,
    [FeedTypeId]          BIGINT NOT NULL,
    [IDEnumValue]         INT              NULL,
    [EnumGroupId]         BIGINT NOT NULL);

