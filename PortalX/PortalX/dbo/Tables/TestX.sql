CREATE TABLE [dbo].[TestX] (
    [Sequence]        BIGINT                                             IDENTITY (1, 1) NOT NULL,
    [Id]              UNIQUEIDENTIFIER                                   NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER                                   NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER                                   NOT NULL,
    [Name]            VARCHAR (25)                                       NOT NULL,
    [Value]           VARCHAR (25)                                       NULL,
    [TimestampUTC]    DATETIME                                           NOT NULL,
    [CreatedDateTime] DATETIME2 (7)                                      CONSTRAINT [DF_TestX_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysStartTime]    DATETIME2 (7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    [SysEndTime]      DATETIME2 (7) GENERATED ALWAYS AS ROW END HIDDEN   NOT NULL,
    CONSTRAINT [PK_TestX_TimestampUTC_Sequence] PRIMARY KEY NONCLUSTERED ([TimestampUTC] ASC, [Sequence] ASC),
    INDEX [IX_TestX_TopicInstanceId_FeedTypeId_TimestampUTC] NONCLUSTERED ([TopicInstanceId], [FeedTypeId], [TimestampUTC]),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (MEMORY_OPTIMIZED = ON, SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[TestXHistory], DATA_CONSISTENCY_CHECK=ON, HISTORY_RETENTION_PERIOD=1 DAY));

