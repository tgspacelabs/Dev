CREATE TABLE [dbo].[EventsData] (
    [Sequence]       BIGINT           IDENTITY (-9223372036854775808, 1) NOT NULL,
    [CategoryValue]  INT              NOT NULL,
    [Type]           INT              NOT NULL,
    [Subtype]        INT              NOT NULL,
    [Value1]         REAL             NOT NULL,
    [Value2]         REAL             NOT NULL,
    [Status]         INT              NOT NULL,
    [Valid_Leads]    INT              NOT NULL,
    [TopicSessionId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]     UNIQUEIDENTIFIER NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL,
    CONSTRAINT [PK_EventsData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_CategoryValue_TimeStampUTC_Type_Subtype]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [CategoryValue] ASC, [TimestampUTC] ASC, [Type] ASC, [Subtype] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_TimeStampUTC_Subtype_Type_Value1_Value2_Status_Valid_Leads_CategoryValue_0]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [TimestampUTC] ASC)
    INCLUDE([Subtype], [Type], [Value1], [Value2], [Status], [Valid_Leads], [CategoryValue]) WHERE ([CategoryValue] = (0)) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_TimeStampUTC_Subtype_Type_Value1_Value2_Status_Valid_Leads_CategoryValue_1]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [TimestampUTC] ASC)
    INCLUDE([Subtype], [Type], [Value1], [Value2], [Status], [Valid_Leads], [CategoryValue]) WHERE ([CategoryValue]=(2) AND [Type]=(1)) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_TimeStampUTC_Subtype_Type_Value1_Value2_Status_Valid_Leads_CategoryValue_2]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [TimestampUTC] ASC, [Subtype] ASC, [Type] ASC)
    INCLUDE([Value1], [Value2], [Status], [Valid_Leads], [CategoryValue]) WHERE ([CategoryValue]=(2) AND ([Type] IN ((3), (4), (12)))) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Data from the XTR/ETR receivers.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventsData';

