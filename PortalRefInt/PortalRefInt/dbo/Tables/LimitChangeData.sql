CREATE TABLE [dbo].[LimitChangeData] (
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
    [IDEnumValue]         INT              NOT NULL,
    [Sequence]            BIGINT           IDENTITY (-9223372036854775808, 1) NOT NULL,
    CONSTRAINT [PK_LimitChangeData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_LimitChangeData_TopicFeedTypes_FeedTypeId] FOREIGN KEY ([FeedTypeId]) REFERENCES [dbo].[TopicFeedTypes] ([FeedTypeId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Records changes to limit values.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LimitChangeData';

