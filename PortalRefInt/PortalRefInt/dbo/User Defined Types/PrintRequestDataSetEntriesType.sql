CREATE TYPE [dbo].[PrintRequestDataSetEntriesType] AS TABLE (
    [PrintRequestId]       BIGINT NOT NULL,
    [PrintJobId]           BIGINT NOT NULL,
    [TopicSessionId]       BIGINT NOT NULL,
    [FeedTypeId]           BIGINT NOT NULL,
    [RequestTypeEnumId]    BIGINT NOT NULL,
    [RequestTypeEnumValue] INT              NOT NULL,
    [TimestampUTC]         DATETIME         NOT NULL);

