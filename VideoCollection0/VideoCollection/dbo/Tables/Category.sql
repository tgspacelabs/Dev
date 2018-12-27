CREATE TABLE [dbo].[Category] (
    [CategoryID] SMALLINT       IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Category_CategoryID] PRIMARY KEY CLUSTERED ([CategoryID] ASC),
    CONSTRAINT [CK_Category_Category] CHECK (len([Name])>(0))
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Category]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Category';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Category].[CategoryID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Category', @level2type = N'COLUMN', @level2name = N'CategoryID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Category].[Name]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Category', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Category].[PK_Category_CategoryID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Category', @level2type = N'CONSTRAINT', @level2name = N'PK_Category_CategoryID';

