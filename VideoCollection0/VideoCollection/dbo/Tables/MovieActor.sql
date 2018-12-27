CREATE TABLE [dbo].[MovieActor] (
    [MovieActor] INT IDENTITY (1, 1) NOT NULL,
    [MovieID]    INT DEFAULT ((0)) NOT NULL,
    [ActorID]    INT DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_MovieActor_MovieID_ActorID] PRIMARY KEY CLUSTERED ([MovieID] ASC, [ActorID] ASC),
    CONSTRAINT [FK_MovieActor_Actor_ActorID] FOREIGN KEY ([ActorID]) REFERENCES [dbo].[Actor] ([ActorID]),
    CONSTRAINT [FK_MovieActor_Movie_MovieID] FOREIGN KEY ([MovieID]) REFERENCES [dbo].[Movie] ([MovieID])
);


GO
CREATE NONCLUSTERED INDEX [IX_MovieActor_ActorID]
    ON [dbo].[MovieActor]([ActorID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MovieActor_MovieID]
    ON [dbo].[MovieActor]([MovieID] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[MovieActor].[ActorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MovieActor', @level2type = N'INDEX', @level2name = N'IX_MovieActor_ActorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[MovieActor].[MovieID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MovieActor', @level2type = N'INDEX', @level2name = N'IX_MovieActor_MovieID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[MovieActor]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MovieActor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[MovieActor].[MovieID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MovieActor', @level2type = N'COLUMN', @level2name = N'MovieID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[MovieActor].[ActorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MovieActor', @level2type = N'COLUMN', @level2name = N'ActorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[MovieActor].[PK_MovieActor_MovieID_ActorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MovieActor', @level2type = N'CONSTRAINT', @level2name = N'PK_MovieActor_MovieID_ActorID';

