CREATE TABLE [dbo].[Movie] (
    [MovieID]       INT            IDENTITY (1, 1) NOT NULL,
    [Title]         NVARCHAR (255) NOT NULL,
    [CategoryID]    SMALLINT       DEFAULT ((0)) NOT NULL,
    [YearOfRelease] SMALLINT       DEFAULT ((0)) NOT NULL,
    [LengthMinutes] SMALLINT       DEFAULT ((0)) NOT NULL,
    [DirectorID]    INT            DEFAULT ((0)) NOT NULL,
    [MediumID]      TINYINT        NOT NULL,
    CONSTRAINT [PK_Movie_MovieID] PRIMARY KEY CLUSTERED ([MovieID] ASC),
    CONSTRAINT [CK_Movie_LengthMinutes] CHECK ([LengthMinutes]>=(0)),
    CONSTRAINT [CK_Movie_Title] CHECK (len([Title])>(0)),
    CONSTRAINT [FK_Movie_Category_CategoryID] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Category] ([CategoryID]),
    CONSTRAINT [FK_Movie_Director_DirectorID] FOREIGN KEY ([DirectorID]) REFERENCES [dbo].[Director] ([DirectorID]),
    CONSTRAINT [FK_Movie_Medium_MediumID] FOREIGN KEY ([MediumID]) REFERENCES [dbo].[Medium] ([MediumID])
);


GO
CREATE NONCLUSTERED INDEX [IX_Movie_DirectorID]
    ON [dbo].[Movie]([DirectorID] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie].[DirectorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie', @level2type = N'INDEX', @level2name = N'IX_Movie_DirectorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie].[MovieID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie', @level2type = N'COLUMN', @level2name = N'MovieID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie].[Title]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie', @level2type = N'COLUMN', @level2name = N'Title';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie].[CategoryID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie', @level2type = N'COLUMN', @level2name = N'CategoryID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie].[YearOfRelease]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie', @level2type = N'COLUMN', @level2name = N'YearOfRelease';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie].[Length]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie', @level2type = N'COLUMN', @level2name = N'LengthMinutes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie].[DirectorID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie', @level2type = N'COLUMN', @level2name = N'DirectorID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'[VideoCollection].[Movie].[PK_Movie_MovieID]', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Movie', @level2type = N'CONSTRAINT', @level2name = N'PK_Movie_MovieID';

