CREATE TABLE [dbo].[LiveData] (
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    CONSTRAINT [PK_LiveData_TimestampUTC_Sequence] PRIMARY KEY CLUSTERED ([TimestampUTC] ASC, [Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_TopicInstanceId_FeedTypeId_Name_Value_Id]
    ON [dbo].[LiveData]([TopicInstanceId] ASC, [FeedTypeId] ASC)
    INCLUDE([Name], [Value], [Id]) WITH (FILLFACTOR = 100);

