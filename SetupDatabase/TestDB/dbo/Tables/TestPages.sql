CREATE TABLE [dbo].[TestPages] (
    [TestPagesID] INT          IDENTITY (1, 1) NOT NULL,
    [Filler]      NCHAR (2000) NULL,
    CONSTRAINT [PK_TestPages_ID] PRIMARY KEY CLUSTERED ([TestPagesID] ASC) WITH (FILLFACTOR = 100)
);

