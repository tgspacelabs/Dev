CREATE TABLE [dbo].[Director]
    (
        [DirectorID] INT           IDENTITY(1, 1) NOT NULL,
        [Director]   NVARCHAR(100) NOT NULL,
        CONSTRAINT [PK_Director]
            PRIMARY KEY CLUSTERED ([DirectorID] ASC)
    );

