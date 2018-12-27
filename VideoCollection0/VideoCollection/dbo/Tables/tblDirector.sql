CREATE TABLE [dbo].[tblDirector] (
    [ID]       INT           IDENTITY (1, 1) NOT NULL,
    [Director] NVARCHAR (50) NULL,
    CONSTRAINT [tblDirector$PrimaryKey] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [SSMA_CC$tblDirector$Director$disallow_zero_length] CHECK (len([Director])>(0))
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblDirector]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDirector';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblDirector].[ID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDirector', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblDirector].[Director]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDirector', @level2type = N'COLUMN', @level2name = N'Director';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblDirector].[PrimaryKey]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDirector', @level2type = N'CONSTRAINT', @level2name = N'tblDirector$PrimaryKey';

