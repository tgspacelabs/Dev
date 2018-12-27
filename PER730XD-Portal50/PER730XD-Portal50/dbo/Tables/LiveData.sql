CREATE TABLE [dbo].[LiveData] (
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_LiveData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_TopicInstanceId_TimestampUTC]
    ON [dbo].[LiveData]([TopicInstanceId] ASC, [TimestampUTC] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_TopicInstanceId_FeedTypeId_TimestampUTC]
    ON [dbo].[LiveData]([TopicInstanceId] ASC, [FeedTypeId] ASC, [TimestampUTC] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_TimeStampUTC]
    ON [dbo].[LiveData]([TimestampUTC] ASC) WITH (FILLFACTOR = 100);

