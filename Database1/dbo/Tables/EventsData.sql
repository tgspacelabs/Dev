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
    CONSTRAINT [PK_EventsData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_CategoryValue_TimeStampUTC_Type_Subtype]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [CategoryValue] ASC, [TimeStampUTC] ASC, [Type] ASC, [Subtype] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_TimeStampUTC]
    ON [dbo].[EventsData]([TimeStampUTC] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_EventsData_CategoryValue_TopicSessionId_includes]
    ON [dbo].[EventsData]([CategoryValue] ASC, [TopicSessionId] ASC)
    INCLUDE([Type], [Subtype], [Value1], [Value2], [status], [valid_leads], [TimeStampUTC]) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_EventsData_TopicSessionId_TimeStampUTC_CategoryValue_Type_Subtype_Sequence]
    ON [dbo].[EventsData]([TopicSessionId] ASC, [TimeStampUTC] ASC, [CategoryValue] ASC, [Type] ASC, [Subtype] ASC, [Sequence] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventsData';

