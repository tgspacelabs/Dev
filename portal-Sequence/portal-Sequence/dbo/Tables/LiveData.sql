CREATE TABLE [dbo].[LiveData] (
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    CONSTRAINT [PK_LiveData_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_FeedTypeId_Name_TopicInstanceId_Value_TimestampUTC]
    ON [dbo].[LiveData]([FeedTypeId] ASC, [Name] ASC)
    INCLUDE([TopicInstanceId], [Value], [TimestampUTC]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_TopicInstanceId_TimestampUTC_FeedTypeId_Name_Value]
    ON [dbo].[LiveData]([TopicInstanceId] ASC, [TimestampUTC] ASC)
    INCLUDE([FeedTypeId], [Name], [Value]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This is the live feed data for a patient topic session.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LiveData';

