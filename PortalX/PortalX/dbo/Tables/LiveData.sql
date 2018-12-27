CREATE TABLE [dbo].[LiveData] (
    [Sequence]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [Id]              UNIQUEIDENTIFIER NOT NULL,
    [TopicInstanceId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]      UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (25)     NOT NULL,
    [Value]           VARCHAR (25)     NULL,
    [TimestampUTC]    DATETIME         NOT NULL,
    [CreatedDateTime] DATETIME2 (7)    CONSTRAINT [DF_LiveData_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_LiveData_TimestampUTC_Sequence] PRIMARY KEY CLUSTERED ([TimestampUTC] ASC, [Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_TopicInstanceId_FeedTypeId_TimestampUTC]
    ON [dbo].[LiveData]([TopicInstanceId] ASC, [FeedTypeId] ASC, [TimestampUTC] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This is the live feed data for a patient topic session.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LiveData';

