CREATE TABLE [dbo].[EventsData] (
    [Sequence]       BIGINT           IDENTITY (-9223372036854775808, 1) NOT NULL,
    [CategoryValue]  INT              NOT NULL,
    [Type]           INT              NOT NULL,
    [Subtype]        INT              NOT NULL,
    [Value1]         REAL             NOT NULL,
    [Value2]         REAL             NOT NULL,
    [Status]         INT              NOT NULL,
    [Valid_Leads]    INT              NOT NULL,
    [TopicSessionId] BIGINT NOT NULL,
    [FeedTypeId]     BIGINT NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL,
    CONSTRAINT [PK_EventsData_TimeStampUTC_Sequence] PRIMARY KEY CLUSTERED ([TimestampUTC] ASC, [Sequence] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_EventsData_TopicFeedTypes_FeedTypeId] FOREIGN KEY ([FeedTypeId]) REFERENCES [dbo].[TopicFeedTypes] ([FeedTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_CategoryValue_Type_TopicSessionId_Subtype_Value1_status_valid_leads_TimeStampUTC]
    ON [dbo].[EventsData]([CategoryValue] ASC, [Type] ASC, [TopicSessionId] ASC)
    INCLUDE([Subtype], [Value1], [Status], [Valid_Leads], [TimestampUTC]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_CategoryValue_TopicSessionId_TimestampUTC_Type_Subtype_Value1_Value2_Status_Valid_Leads]
    ON [dbo].[EventsData]([CategoryValue] ASC, [TopicSessionId] ASC, [TimestampUTC] ASC)
    INCLUDE([Type], [Subtype], [Value1], [Value2], [Status], [Valid_Leads]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Data from the XTR/ETR receivers.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventsData';

