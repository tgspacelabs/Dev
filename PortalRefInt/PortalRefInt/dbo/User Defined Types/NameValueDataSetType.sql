CREATE TYPE [dbo].[NameValueDataSetType] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [SetId]          BIGINT NOT NULL,
    [Name]           VARCHAR (25)     NOT NULL,
    [Value]          VARCHAR (25)     NULL,
    [FeedTypeId]     BIGINT NOT NULL,
    [TopicSessionId] BIGINT NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL);

