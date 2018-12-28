CREATE TABLE [dbo].[StatusSet] (
    [StatusSetID]     INT           IDENTITY (1, 1) NOT NULL,
    [TopicSessionID]  INT           NOT NULL,
    [FeedTypeID]      INT           NOT NULL,
    [Timestamp]       DATETIME2 (7) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_StatusSet_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_StatusSet_StatusSetID] PRIMARY KEY CLUSTERED ([StatusSetID] ASC),
    CONSTRAINT [FK_StatusSet_FeedType_FeedTypeID] FOREIGN KEY ([FeedTypeID]) REFERENCES [dbo].[FeedType] ([FeedTypeID]),
    CONSTRAINT [FK_StatusSet_TopicSession_TopicSessionID] FOREIGN KEY ([TopicSessionID]) REFERENCES [dbo].[TopicSession] ([TopicSessionID])
);


GO
CREATE NONCLUSTERED INDEX [IX_StatusSet_TimestampUTC_StatusSetID]
    ON [dbo].[StatusSet]([Timestamp] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_StatusSet_FeedType_FeedTypeID]
    ON [dbo].[StatusSet]([FeedTypeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_StatusSet_TopicSession_TopicSessionID]
    ON [dbo].[StatusSet]([TopicSessionID] ASC);

