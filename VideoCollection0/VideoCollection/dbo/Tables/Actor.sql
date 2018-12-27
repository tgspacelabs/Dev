CREATE TABLE [dbo].[Actor] (
    [ActorID]   INT           IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (50) NOT NULL,
    [LastName]  NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Actor_ActorID] PRIMARY KEY CLUSTERED ([ActorID] ASC),
    CONSTRAINT [CK_Actor_FirstName] CHECK (len([FirstName])>(0)),
    CONSTRAINT [CK_Actor_LastName] CHECK (len([LastName])>(0))
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Actor]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Actor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Actor].[ActorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Actor', @level2type = N'COLUMN', @level2name = N'ActorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Actor].[FirstName]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Actor', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Actor].[LastName]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Actor', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Actor].[PK_Actor_ActorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Actor', @level2type = N'CONSTRAINT', @level2name = N'PK_Actor_ActorID';

