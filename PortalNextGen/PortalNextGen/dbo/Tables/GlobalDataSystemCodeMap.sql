CREATE TABLE [dbo].[GlobalDataSystemCodeMap] (
    [GlobalDataSystemCodeMapID] INT           IDENTITY (1, 1) NOT NULL,
    [FeedTypeID]                INT           NOT NULL,
    [Name]                      VARCHAR (25)  NOT NULL,
    [GlobalDataSystemCode]      VARCHAR (25)  NOT NULL,
    [CodeID]                    INT           NOT NULL,
    [Units]                     VARCHAR (25)  NULL,
    [Description]               NVARCHAR (50) NULL,
    [CreatedDateTime]           DATETIME2 (7) CONSTRAINT [DF_GlobalDataSystemCodeMap_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_GlobalDataSystemCodeMap_GlobalDataSystemCodeMapID] PRIMARY KEY CLUSTERED ([GlobalDataSystemCodeMapID] ASC),
    CONSTRAINT [FK_GlobalDataSystemCodeMap_FeedType_FeedTypeID] FOREIGN KEY ([FeedTypeID]) REFERENCES [dbo].[FeedType] ([FeedTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_GlobalDataSystemCodeMap_GlobalDataSystemCode_CodeID_Description_Units_FeedTypeID_Name]
    ON [dbo].[GlobalDataSystemCodeMap]([GlobalDataSystemCode] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_GlobalDataSystemCodeMap_FeedTypeID_Name]
    ON [dbo].[GlobalDataSystemCodeMap]([FeedTypeID] ASC, [Name] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_GlobalDataSystemCodeMap_FeedType_FeedTypeID]
    ON [dbo].[GlobalDataSystemCodeMap]([FeedTypeID] ASC);

