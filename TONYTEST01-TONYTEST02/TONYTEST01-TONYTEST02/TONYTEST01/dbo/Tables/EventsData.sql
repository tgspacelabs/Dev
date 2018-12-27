CREATE TABLE [dbo].[EventsData] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [CategoryValue]  INT              NOT NULL,
    [Type]           INT              NOT NULL,
    [Subtype]        INT              NOT NULL,
    [Value1]         REAL             NOT NULL,
    [Value2]         REAL             NOT NULL,
    [status]         INT              NOT NULL,
    [valid_leads]    INT              NOT NULL,
    [TopicSessionId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]     UNIQUEIDENTIFIER NOT NULL,
    [TimeStampUTC]   DATETIME         NOT NULL,
    [Sequence]       BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_EventsData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_CategoryValue_TimeStampUTC_Type_Subtype]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [CategoryValue] ASC, [TimeStampUTC] ASC, [Type] ASC, [Subtype] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_TimeStampUTC_Subtype_Type_Value1_Value2_status_valid_leads_0]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [TimeStampUTC] ASC)
    INCLUDE([Subtype], [Type], [Value1], [Value2], [status], [valid_leads]) WHERE ([CategoryValue]=(0));


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_TimeStampUTC_Subtype_Type_Value1_Value2_status_valid_leads_1]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [TimeStampUTC] ASC)
    INCLUDE([Subtype], [Type], [Value1], [Value2], [status], [valid_leads]) WHERE ([CategoryValue]=(2) AND [Type]=(1));


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_TimeStampUTC_Subtype_Type_Value1_Value2_status_valid_leads_2]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [TimeStampUTC] ASC, [Subtype] ASC, [Type] ASC)
    INCLUDE([Value1], [Value2], [status], [valid_leads]) WHERE ([CategoryValue]=(2) AND ([Type] IN ((3), (4), (12))));

