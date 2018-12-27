CREATE TABLE [dbo].[Change]
(
    [ChangeID] INT NOT NULL , 
    [Title] NVARCHAR(50) NOT NULL, 
    [Description] NVARCHAR(2000) NOT NULL, 
    CONSTRAINT [PK_Change_ChangeID] PRIMARY KEY ([Title]) 
)

GO

CREATE UNIQUE INDEX [IX_Change_Title] ON [dbo].[Change] ([Title])
