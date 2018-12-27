CREATE TABLE [dbo].[StatusDataSets] (
    [Id]             UNIQUEIDENTIFIER NOT NULL,
    [TopicSessionId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]     UNIQUEIDENTIFIER NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL,
    [Sequence]       BIGINT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_StatusDataSets_Sequence] PRIMARY KEY CLUSTERED ([Sequence] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusDataSets_5_1623676832__K1_2_3_4]
    ON [dbo].[StatusDataSets]([Id] ASC)
    INCLUDE([TopicSessionId], [FeedTypeId], [TimestampUTC]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusDataSets_5_1623676832__K2_K3_K4_K1]
    ON [dbo].[StatusDataSets]([TopicSessionId] ASC, [FeedTypeId] ASC, [TimestampUTC] ASC, [Id] ASC);

