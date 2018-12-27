CREATE TABLE [dbo].[GdsCodeMap] (
    [FeedTypeId]  UNIQUEIDENTIFIER NOT NULL,
    [Name]        VARCHAR (25)     NOT NULL,
    [GdsCode]     VARCHAR (25)     NOT NULL,
    [CodeId]      INT              NOT NULL,
    [Units]       VARCHAR (25)     NULL,
    [Description] NVARCHAR (50)    NULL,
    CONSTRAINT [PK_GdsCodeMap_FeedTypeId_Name] PRIMARY KEY CLUSTERED ([FeedTypeId] ASC, [Name] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_GdsCodeMap_CodeId_FeedTypeId_Name]
    ON [dbo].[GdsCodeMap]([CodeId] ASC)
    INCLUDE([FeedTypeId], [Name]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_GdsCodeMap_GdsCode_FeedTypeId_Name]
    ON [dbo].[GdsCodeMap]([GdsCode] ASC)
    INCLUDE([FeedTypeId], [Name]) WITH (FILLFACTOR = 100);

