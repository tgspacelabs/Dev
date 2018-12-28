CREATE TABLE [dbo].[GeneralAlarm] (
    [GeneralAlarmID]      INT           IDENTITY (1, 1) NOT NULL,
    [StatusTimeout]       TINYINT       NULL,
    [StartDateTime]       DATETIME2 (7) NOT NULL,
    [EndDateTime]         DATETIME2 (7) NULL,
    [StatusValue]         INT           NOT NULL,
    [PriorityWeightValue] INT           NOT NULL,
    [AcquiredDateTime]    DATETIME2 (7) NOT NULL,
    [Leads]               INT           NOT NULL,
    [WaveformFeedTypeID]  INT           NOT NULL,
    [TopicSessionID]      INT           NOT NULL,
    [FeedTypeID]          INT           NOT NULL,
    [IDEnumValue]         INT           NOT NULL,
    [EnumGroupID]         INT           NOT NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_GeneralAlarm_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_GeneralAlarm_GeneralAlarmID] PRIMARY KEY CLUSTERED ([GeneralAlarmID] ASC),
    CONSTRAINT [FK_GeneralAlarm_FeedType_FeedTypeID] FOREIGN KEY ([FeedTypeID]) REFERENCES [dbo].[FeedType] ([FeedTypeID]),
    CONSTRAINT [FK_GeneralAlarm_TopicSession_TopicSessionID] FOREIGN KEY ([TopicSessionID]) REFERENCES [dbo].[TopicSession] ([TopicSessionID])
);


GO
CREATE NONCLUSTERED INDEX [IX_GeneralAlarm_TopicSessionID_StartDateTime_EndDateTime_includes]
    ON [dbo].[GeneralAlarm]([TopicSessionID] ASC, [StartDateTime] ASC, [EndDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_GeneralAlarm_EndDateTime_TopicSessionID]
    ON [dbo].[GeneralAlarm]([EndDateTime] ASC, [TopicSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_GeneralAlarm_StartDateTime]
    ON [dbo].[GeneralAlarm]([StartDateTime] DESC);


GO
CREATE NONCLUSTERED INDEX [FK_GeneralAlarm_FeedType_FeedTypeID]
    ON [dbo].[GeneralAlarm]([FeedTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_GeneralAlarm_TopicSession_TopicSessionID]
    ON [dbo].[GeneralAlarm]([TopicSessionID] ASC);

