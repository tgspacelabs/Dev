CREATE TABLE [dbo].[tblCategory] (
    [CategoryID] INT           IDENTITY (1, 1) NOT NULL,
    [Category]   NVARCHAR (50) NULL,
    CONSTRAINT [tblCategory$PrimaryKey] PRIMARY KEY CLUSTERED ([CategoryID] ASC),
    CONSTRAINT [SSMA_CC$tblCategory$Category$disallow_zero_length] CHECK (len([Category])>(0))
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblCategory]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblCategory';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblCategory].[CategoryID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblCategory', @level2type = N'COLUMN', @level2name = N'CategoryID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblCategory].[Category]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblCategory', @level2type = N'COLUMN', @level2name = N'Category';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblCategory].[PrimaryKey]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblCategory', @level2type = N'CONSTRAINT', @level2name = N'tblCategory$PrimaryKey';

