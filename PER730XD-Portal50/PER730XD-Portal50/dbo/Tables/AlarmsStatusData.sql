CREATE TABLE [dbo].[AlarmsStatusData] (
    [Id]                  UNIQUEIDENTIFIER NOT NULL,
    [AlarmId]             UNIQUEIDENTIFIER NOT NULL,
    [StatusTimeout]       TINYINT          NULL,
    [StatusValue]         INT              NOT NULL,
    [AcquiredDateTimeUTC] DATETIME         NOT NULL,
    [Leads]               INT              NOT NULL,
    [WaveformFeedTypeId]  UNIQUEIDENTIFIER NOT NULL,
    [TopicSessionId]      UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]          UNIQUEIDENTIFIER NOT NULL,
    [IDEnumValue]         INT              NOT NULL,
    [EnumGroupId]         UNIQUEIDENTIFIER NOT NULL,
    [Sequence]            BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_AlarmsStatusData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC)
);

