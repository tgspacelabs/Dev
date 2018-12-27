CREATE TABLE [dbo].[tblMovies] (
    [MovieID]       INT           IDENTITY (1, 1) NOT NULL,
    [Title]         NVARCHAR (50) NOT NULL,
    [Medium]        CHAR (1)      DEFAULT ('D') NOT NULL,
    [CategoryID]    INT           DEFAULT ((0)) NULL,
    [YearOfRelease] SMALLINT      DEFAULT ((0)) NULL,
    [Length]        INT           DEFAULT ((0)) NULL,
    [DirectorID]    INT           DEFAULT ((0)) NULL,
    CONSTRAINT [tblMovies$PrimaryKey] PRIMARY KEY CLUSTERED ([MovieID] ASC),
    CONSTRAINT [SSMA_CC$tblMovies$Medium$disallow_zero_length] CHECK (len([Medium])>(0)),
    CONSTRAINT [SSMA_CC$tblMovies$Title$disallow_zero_length] CHECK (len([Title])>(0))
);


GO
CREATE NONCLUSTERED INDEX [tblMovies$DirectorID]
    ON [dbo].[tblMovies]([DirectorID] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[DirectorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'INDEX', @level2name = N'tblMovies$DirectorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[MovieID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'COLUMN', @level2name = N'MovieID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[Title]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'COLUMN', @level2name = N'Title';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[Medium]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'COLUMN', @level2name = N'Medium';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[CategoryID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'COLUMN', @level2name = N'CategoryID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[YearOfRelease]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'COLUMN', @level2name = N'YearOfRelease';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[Length]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'COLUMN', @level2name = N'Length';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[DirectorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'COLUMN', @level2name = N'DirectorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[tblMovies].[PrimaryKey]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblMovies', @level2type = N'CONSTRAINT', @level2name = N'tblMovies$PrimaryKey';

