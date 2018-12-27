CREATE TYPE [dbo].[EventDataType] AS TABLE (
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
    [TimeStampUTC]   DATETIME         NOT NULL);

