CREATE TABLE [dbo].[DuplicateKey] (
    [DuplicateKeyID] INT           IDENTITY (1, 1) NOT NULL,
    [FirstName]      NVARCHAR (50) NOT NULL,
    [LastName]       NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_DuplicateKey_DuplicateKeyID] PRIMARY KEY CLUSTERED ([DuplicateKeyID] ASC)
);


GO

CREATE INDEX [IX_DuplicateKey_FirstName] ON [dbo].[DuplicateKey] ([FirstName])
