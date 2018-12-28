CREATE TABLE [dbo].[CodeCategory] (
    [CodeCategoryID]  INT           IDENTITY (1, 1) NOT NULL,
    [CategoryCode]    CHAR (4)      NOT NULL,
    [CategoryName]    NVARCHAR (80) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_CodeCategory_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_CodeCategory_CodeCategoryID] PRIMARY KEY CLUSTERED ([CodeCategoryID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CodeCategory_CategoryCode]
    ON [dbo].[CodeCategory]([CategoryCode] ASC);

