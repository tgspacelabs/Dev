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
CREATE NONCLUSTERED INDEX [IX_VitalsData_TopicSessionId_TimestampUTC_Name_FeedTypeId_SetId_Value]
    ON [dbo].[VitalsData]([TopicSessionId] ASC, [TimestampUTC] ASC, [Name] ASC, [FeedTypeId] ASC)
    INCLUDE([SetId], [Value]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'VitalsData';

