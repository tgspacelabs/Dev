CREATE TABLE [dbo].[StatusDataSets] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [TopicSessionId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]     UNIQUEIDENTIFIER NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL,
    CONSTRAINT [PK_StatusDataSets_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_StatusDataSets_TopicSessionId_FeedTypeId_TimestampUTC_Id]
    ON [dbo].[StatusDataSets]([TopicSessionId] ASC, [FeedTypeId] ASC, [TimestampUTC] ASC, [Id] ASC) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StatusDataSets';

