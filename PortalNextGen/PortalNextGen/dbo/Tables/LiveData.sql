CREATE TABLE [dbo].[LiveData] (
    [LiveDataID]      BIGINT        IDENTITY (0, 1) NOT NULL,
    [TopicInstanceID] INT           NOT NULL,
    [FeedTypeID]      INT           NOT NULL,
    [Name]            VARCHAR (25)  NOT NULL,
    [Value]           VARCHAR (25)  NULL,
    [Timestamp]       DATETIME2 (7) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_LiveData_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_LiveData_TimestampUTC_LiveDataID] PRIMARY KEY CLUSTERED ([LiveDataID] ASC, [Timestamp] ASC),
    CONSTRAINT [FK_LiveData_FeedType_FeedTypeID] FOREIGN KEY ([FeedTypeID]) REFERENCES [dbo].[FeedType] ([FeedTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_LiveData_TopicInstanceId_FeedTypeID_Timestamp]
    ON [dbo].[LiveData]([TopicInstanceID] ASC, [FeedTypeID] ASC, [Timestamp] DESC);


GO
CREATE NONCLUSTERED INDEX [FK_LiveData_FeedType_FeedTypeID]
    ON [dbo].[LiveData]([FeedTypeID] ASC);

