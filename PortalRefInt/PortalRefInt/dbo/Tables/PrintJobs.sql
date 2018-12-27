CREATE TABLE [dbo].[PrintJobs] (
    [Id]             BIGINT NOT NULL,
    [TopicSessionId] BIGINT NOT NULL,
    [FeedTypeId]     BIGINT NOT NULL,
    CONSTRAINT [FK_PrintJobs_TopicFeedTypes_FeedTypeId] FOREIGN KEY ([FeedTypeId]) REFERENCES [dbo].[TopicFeedTypes] ([FeedTypeId])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PrintJobs';

