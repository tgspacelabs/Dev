CREATE TABLE [dbo].[VitalsData] (
    [ID]             BIGINT           IDENTITY (1, 1) NOT NULL,
    [SetId]          BIGINT NOT NULL,
    [Name]           VARCHAR (25)     NOT NULL,
    [Value]          VARCHAR (25)     NULL,
    [TopicSessionId] BIGINT NOT NULL,
    [FeedTypeId]     BIGINT NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL,
    CONSTRAINT [PK_VitalsData_ID] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_VitalsData_TopicFeedTypes_FeedTypeId] FOREIGN KEY ([FeedTypeId]) REFERENCES [dbo].[TopicFeedTypes] ([FeedTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_VitalsData_TopicSessionId_TimestampUTC_Name_FeedTypeId_ID_Value]
    ON [dbo].[VitalsData]([TopicSessionId] ASC, [TimestampUTC] ASC, [Name] ASC, [FeedTypeId] ASC)
    INCLUDE([ID], [Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_VitalsData_TimestampUTC_ID]
    ON [dbo].[VitalsData]([TimestampUTC] ASC)
    INCLUDE([ID]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Patient vital sign data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'VitalsData';

