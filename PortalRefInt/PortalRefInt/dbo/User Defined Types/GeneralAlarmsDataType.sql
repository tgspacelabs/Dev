CREATE TYPE [dbo].[GeneralAlarmsDataType] AS TABLE (
    [AlarmId]             BIGINT NOT NULL,
    [StatusTimeout]       TINYINT          NULL,
    [StartDateTime]       DATETIME         NULL,
    [EndDateTime]         DATETIME         NULL,
    [StatusValue]         INT              NOT NULL,
    [PriorityWeightValue] INT              NOT NULL,
    [AcquiredDateTimeUTC] DATETIME         NOT NULL,
    [Leads]               INT              NOT NULL,
    [WaveformFeedTypeId]  BIGINT NOT NULL,
    [TopicSessionId]      BIGINT NOT NULL,
    [FeedTypeId]          BIGINT NOT NULL,
    [IDEnumValue]         INT              NOT NULL,
    [EnumGroupId]         BIGINT NOT NULL);

