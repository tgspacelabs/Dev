CREATE TABLE [dbo].[Movie]
    (
        [MovieID]       INT           IDENTITY(1, 1) NOT NULL,
        [Title]         NVARCHAR(255) NOT NULL,
        [CategoryID]    SMALLINT      NOT NULL,
        [YearOfRelease] SMALLINT      NOT NULL,
        [LengthMinutes] SMALLINT      NOT NULL,
        [DirectorID]    INT           NOT NULL,
        [MediumID]      TINYINT       NOT NULL,
        CONSTRAINT [PK_Movie]
            PRIMARY KEY CLUSTERED ([MovieID] ASC),
        CONSTRAINT [FK_Movie_Category_CategoryID]
            FOREIGN KEY ([CategoryID])
            REFERENCES [dbo].[Category] ([CategoryID]),
        CONSTRAINT [FK_Movie_Director_DirectorID]
            FOREIGN KEY ([DirectorID])
            REFERENCES [dbo].[Director] ([DirectorID]),
        CONSTRAINT [FK_Movie_Medium_MediumID]
            FOREIGN KEY ([MediumID])
            REFERENCES [dbo].[Medium] ([MediumID])
    );

