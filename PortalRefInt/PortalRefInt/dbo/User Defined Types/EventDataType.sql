CREATE TYPE [dbo].[EventDataType] AS TABLE (
    [CategoryValue]  INT              NOT NULL,
    [Type]           INT              NOT NULL,
    [Subtype]        INT              NOT NULL,
    [Value1]         REAL             NOT NULL,
    [Value2]         REAL             NOT NULL,
    [Status]         INT              NOT NULL,
    [Valid_Leads]    INT              NOT NULL,
    [TopicSessionId] BIGINT NOT NULL,
    [FeedTypeId]     BIGINT NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL);

