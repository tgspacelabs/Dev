CREATE TABLE [dbo].[Category]
    (
        [CategoryID] SMALLINT      IDENTITY(1, 1) NOT NULL,
        [Name]       NVARCHAR(100) NOT NULL,
        CONSTRAINT [PK_Category]
            PRIMARY KEY CLUSTERED ([CategoryID] ASC)
    );

