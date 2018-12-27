CREATE TABLE [dbo].[IndexChange] (
    [IndexChangeID] INT             IDENTITY (1, 1) NOT NULL,
    [FullName]          NVARCHAR (50)   NOT NULL,
    [Description]   NVARCHAR (2000) NOT NULL,
    CONSTRAINT [PK_IndexChange_IndexChangeID] PRIMARY KEY CLUSTERED ([IndexChangeID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_IndexChange_Name]
    ON [dbo].[IndexChange]([FullName] ASC) WITH (FILLFACTOR = 100);


GO
