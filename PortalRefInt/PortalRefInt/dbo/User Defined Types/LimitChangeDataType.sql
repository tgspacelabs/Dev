CREATE TYPE [dbo].[LimitChangeDataType] AS TABLE (
    [Id]                  BIGINT NOT NULL,
    [High]                VARCHAR (25)     NULL,
    [Low]                 VARCHAR (25)     NULL,
    [ExtremeHigh]         VARCHAR (25)     NULL,
    [ExtremeLow]          VARCHAR (25)     NULL,
    [Desat]               VARCHAR (25)     NULL,
    [AcquiredDateTimeUTC] DATETIME         NOT NULL,
    [TopicSessionId]      BIGINT NOT NULL,
    [FeedTypeId]          BIGINT NOT NULL,
    [EnumGroupId]         BIGINT NOT NULL,
    [IDEnumValue]         INT              NOT NULL);

