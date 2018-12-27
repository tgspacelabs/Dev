CREATE TABLE [dbo].[StatusDataSets] (
    [Id]             BIGINT NOT NULL,
    [TopicSessionId] BIGINT NOT NULL,
    [FeedTypeId]     BIGINT NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL,
    CONSTRAINT [PK_StatusDataSets_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_StatusDataSets_TopicFeedTypes_FeedTypeId] FOREIGN KEY ([FeedTypeId]) REFERENCES [dbo].[TopicFeedTypes] ([FeedTypeId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StatusDataSets';

