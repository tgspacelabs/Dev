CREATE TABLE [dbo].[ResourceString] (
    [ResourceStringID] INT            IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (250) NOT NULL,
    [Value]            NVARCHAR (250) NULL,
    [Comment]          NVARCHAR (250) NULL,
    [Locale]           NVARCHAR (50)  NOT NULL,
    [CreatedDateTime]  DATETIME2 (7)  CONSTRAINT [DF_ResourceString_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ResourceString_ResourceStringID] PRIMARY KEY CLUSTERED ([ResourceStringID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ResourceString_Locale_Name]
    ON [dbo].[ResourceString]([Locale] ASC, [Name] ASC);

