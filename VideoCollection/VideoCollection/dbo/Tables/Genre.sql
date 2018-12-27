CREATE TABLE [dbo].[Genre]
    (
        [GenreID] SMALLINT    IDENTITY(1, 1) NOT NULL,
        [Genre]   VARCHAR(50) NOT NULL,
        CONSTRAINT [PK_Genre]
            PRIMARY KEY CLUSTERED ([GenreID] ASC)
    );

