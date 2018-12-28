CREATE TABLE [dbo].[FeedType] (
    [FeedTypeID]      INT            IDENTITY (1, 1) NOT NULL,
    [TopicTypeID]     INT            NOT NULL,
    [ChannelCode]     INT            NOT NULL,
    [ChannelTypeID]   INT            NOT NULL,
    [SampleRate]      SMALLINT       NULL,
    [Label]           NVARCHAR (250) NOT NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_FeedType_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_FeedType_FeedTypeID] PRIMARY KEY CLUSTERED ([FeedTypeID] ASC),
    CONSTRAINT [FK_FeedType_TopicType_TopicTypeID] FOREIGN KEY ([TopicTypeID]) REFERENCES [dbo].[TopicType] ([TopicTypeID])
);


GO
CREATE NONCLUSTERED INDEX [FK_FeedType_TopicType_TopicTypeID]
    ON [dbo].[FeedType]([TopicTypeID] ASC);

