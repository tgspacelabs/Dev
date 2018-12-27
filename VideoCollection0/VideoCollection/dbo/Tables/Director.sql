CREATE TABLE [dbo].[Director] (
    [DirectorID] INT            IDENTITY (1, 1) NOT NULL,
    [Director]   NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Director_DirectorID] PRIMARY KEY CLUSTERED ([DirectorID] ASC),
    CONSTRAINT [CK_Director_Director] CHECK (len([Director])>(0))
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Director]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Director';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Director].[DirectorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Director', @level2type = N'COLUMN', @level2name = N'DirectorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Director].[Director]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Director', @level2type = N'COLUMN', @level2name = N'Director';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Director].[PrimaryKey]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Director', @level2type = N'CONSTRAINT', @level2name = N'PK_Director_DirectorID';

