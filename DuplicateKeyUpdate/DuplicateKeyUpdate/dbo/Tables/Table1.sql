CREATE TABLE [dbo].[Table1]
(
    [Table1Id] INT NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(50) NOT NULL, 
    [DuplicateKeyID] INT NOT NULL, 
    CONSTRAINT [FK_Table1_DuplicateKey_DuplicateKeyID] FOREIGN KEY ([DuplicateKeyID]) REFERENCES [DuplicateKey]([DuplicateKeyID])
)
