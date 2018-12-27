CREATE TABLE [dbo].[LiveData] (
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    CONSTRAINT [PK_LiveDataX_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_LiveDataX_TopicInstanceId_FeedTypeId_Name_Value_TimestampUTC]
    ON [dbo].[LiveData]([TopicInstanceId] ASC)
    INCLUDE([FeedTypeId], [Name], [Value], [TimestampUTC]);

