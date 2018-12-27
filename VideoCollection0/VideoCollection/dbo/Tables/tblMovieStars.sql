CREATE TABLE [dbo].[tblMovieStars] (
    [MovieID] INT DEFAULT ((0)) NOT NULL,
    [ActorID] INT DEFAULT ((0)) NOT NULL,
    CONSTRAINT [tblMovieStars$PrimaryKey] PRIMARY KEY CLUSTERED ([MovieID] ASC, [ActorID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [tblMovieStars$ActorID]
    ON [dbo].[tblMovieStars]([ActorID] ASC);


GO
CREATE NONCLUSTERED INDEX [tblMovieStars$MovieID]
    ON [dbo].[tblMovieStars]([MovieID] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovieStars].[ActorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovieStars', @level2type = N'INDEX', @level2name = N'tblMovieStars$ActorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovieStars].[MovieID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovieStars', @level2type = N'INDEX', @level2name = N'tblMovieStars$MovieID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovieStars]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovieStars';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovieStars].[MovieID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovieStars', @level2type = N'COLUMN', @level2name = N'MovieID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovieStars].[ActorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovieStars', @level2type = N'COLUMN', @level2name = N'ActorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovieStars].[PrimaryKey]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovieStars', @level2type = N'CONSTRAINT', @level2name = N'tblMovieStars$PrimaryKey';

