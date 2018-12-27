CREATE TABLE [dbo].[VitalsData] (
    [ID]             BIGINT           IDENTITY (1, 1) NOT NULL,
    [SetId]          UNIQUEIDENTIFIER NOT NULL,
    [Name]           VARCHAR (25)     NOT NULL,
    [Value]          VARCHAR (25)     NULL,
    [TopicSessionId] UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]     UNIQUEIDENTIFIER NOT NULL,
    [TimestampUTC]   DATETIME         NOT NULL,
    CONSTRAINT [PK_VitalsData_TimestampUTC_ID] PRIMARY KEY CLUSTERED ([TimestampUTC] ASC, [ID] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_VitalsData_TopicSessionId_TimestampUTC_Name_FeedTypeId_ID_Value]
    ON [dbo].[VitalsData]([TopicSessionId] ASC, [TimestampUTC] ASC, [Name] ASC, [FeedTypeId] ASC)
    INCLUDE([ID], [Value]) WITH (FILLFACTOR = 100);

