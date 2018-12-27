CREATE TABLE [dbo].[TestXHistory] (
    [Sequence]        BIGINT           NOT NULL,
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [CreatedDateTime] DATETIME2 (7)    NOT NULL,
    [SysStartTime]    DATETIME2 (7)    NOT NULL,
    [SysEndTime]      DATETIME2 (7)    NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_TestXHistory]
    ON [dbo].[TestXHistory]([SysEndTime] ASC, [SysStartTime] ASC);

