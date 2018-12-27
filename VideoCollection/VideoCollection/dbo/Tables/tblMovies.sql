CREATE TABLE [dbo].[tblMovies] (
    [MovieID]       INT           NOT NULL,
    [Title]         NVARCHAR (50) NOT NULL,
    [Medium]        CHAR (1)      NOT NULL,
    [CategoryID]    INT           NULL,
    [YearOfRelease] SMALLINT      NULL,
    [Length]        INT           NULL,
    [DirectorID]    INT           NULL
);

