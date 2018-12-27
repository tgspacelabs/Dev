CREATE TABLE [dbo].[StatusDataSets] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [TopicSessionId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]     UNIQUEIDENTIFIER NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL,
    CONSTRAINT [PK_StatusDataSets_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusDataSets_5_1623676832__K2_K1_4]
    ON [dbo].[StatusDataSets]([TopicSessionId] ASC, [Id] ASC)
    INCLUDE([TimestampUTC]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusDataSets_5_1623676832__K2_K1]
    ON [dbo].[StatusDataSets]([TopicSessionId] ASC, [Id] ASC);


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusDataSets_5_1623676832__K1_2_3_4]
    ON [dbo].[StatusDataSets]([Id] ASC)
    INCLUDE([TopicSessionId], [FeedTypeId], [TimestampUTC]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusDataSets_5_1623676832__K2_K1_3_4]
    ON [dbo].[StatusDataSets]([TopicSessionId] ASC, [Id] ASC)
    INCLUDE([FeedTypeId], [TimestampUTC]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusDataSets_5_1623676832__K2_K3_K4_K1]
    ON [dbo].[StatusDataSets]([TopicSessionId] ASC, [FeedTypeId] ASC, [TimestampUTC] ASC, [Id] ASC);

