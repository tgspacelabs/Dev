CREATE TABLE [dbo].[Event] (
    [EventID]         BIGINT        IDENTITY (0, 1) NOT NULL,
    [CategoryValue]   INT           NOT NULL,
    [Type]            INT           NOT NULL,
    [Subtype]         INT           NOT NULL,
    [Value1]          REAL          NOT NULL,
    [Value2]          REAL          NOT NULL,
    [Status]          INT           NOT NULL,
    [ValidLeads]      INT           NOT NULL,
    [TopicSessionID]  INT           NOT NULL,
    [FeedTypeID]      INT           NOT NULL,
    [Timestamp]       DATETIME2 (7) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Event_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Event_EventID] PRIMARY KEY CLUSTERED ([EventID] ASC),
    CONSTRAINT [FK_Event_FeedType_FeedTypeID] FOREIGN KEY ([FeedTypeID]) REFERENCES [dbo].[FeedType] ([FeedTypeID]),
    CONSTRAINT [FK_Event_TopicSession_TopicSessionID] FOREIGN KEY ([TopicSessionID]) REFERENCES [dbo].[TopicSession] ([TopicSessionID])
);


GO
CREATE NONCLUSTERED INDEX [IX_Event_TimeStamp_EventID]
    ON [dbo].[Event]([Timestamp] ASC, [EventID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_CategoryValue_Type_TopicSessionID_Subtype_Value1_Status_ValidLeads_TimeStamp]
    ON [dbo].[Event]([CategoryValue] ASC, [Type] ASC, [TopicSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_CategoryValue_TopicSessionID_TimestampUTC_Type_Subtype_Value1_Value2_Status_Valid_Leads]
    ON [dbo].[Event]([CategoryValue] ASC, [TopicSessionID] ASC, [Timestamp] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Event_FeedType_FeedTypeID]
    ON [dbo].[Event]([FeedTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Event_TopicSession_TopicSessionID]
    ON [dbo].[Event]([TopicSessionID] ASC);

