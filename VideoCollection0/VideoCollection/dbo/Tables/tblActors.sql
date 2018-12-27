CREATE TABLE [dbo].[tblActors] (
    [ActorID]   INT           IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (25) NULL,
    [LastName]  NVARCHAR (25) NULL,
    CONSTRAINT [tblActors$PrimaryKey] PRIMARY KEY CLUSTERED ([ActorID] ASC),
    CONSTRAINT [SSMA_CC$tblActors$FirstName$disallow_zero_length] CHECK (len([FirstName])>(0)),
    CONSTRAINT [SSMA_CC$tblActors$LastName$disallow_zero_length] CHECK (len([LastName])>(0))
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblActors]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblActors';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblActors].[ActorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblActors', @level2type = N'COLUMN', @level2name = N'ActorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblActors].[FirstName]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblActors', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblActors].[LastName]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblActors', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblActors].[PrimaryKey]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblActors', @level2type = N'CONSTRAINT', @level2name = N'tblActors$PrimaryKey';

