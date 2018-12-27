CREATE TABLE [dbo].[Medium]
    (
        [MediumID] TINYINT      IDENTITY(1, 1) NOT NULL,
        [Format]   NVARCHAR(50) NOT NULL,
        CONSTRAINT [PK_Medium]
            PRIMARY KEY CLUSTERED ([MediumID] ASC)
    );

