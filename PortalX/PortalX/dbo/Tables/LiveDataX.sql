CREATE TABLE [dbo].[LiveDataX] (
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [CreatedDateTime] DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_LiveDataX_TimestampUTC_Sequence] PRIMARY KEY NONCLUSTERED ([TimestampUTC] ASC, [Sequence] ASC),
    INDEX [IX_LiveDataX_TopicInstanceId_TimestampUTC] NONCLUSTERED ([TopicInstanceId], [TimestampUTC])
)
WITH (MEMORY_OPTIMIZED = ON);

