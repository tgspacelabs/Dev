CREATE TABLE [dbo].[Person]
(
    [PersonID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [FirstName] NVARCHAR(50) NOT NULL, 
    [LastName] NVARCHAR(50) NOT NULL, 
    [Created] DATETIME2 NOT NULL DEFAULT sysdatetime(), 
    [Updated] DATETIME2 NOT NULL DEFAULT sysdatetime()
)

GO

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Person table primary key field',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Person',
    @level2type = N'COLUMN',
    @level2name = N'PersonID'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'First name of the person',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Person',
    @level2type = N'COLUMN',
    @level2name = N'FirstName'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Last name of the person',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Person',
    @level2type = N'COLUMN',
    @level2name = N'LastName'
GO

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Date and time the row was created.',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Person',
    @level2type = N'COLUMN',
    @level2name = N'Created'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Date and time the row was updated.',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Person',
    @level2type = N'COLUMN',
    @level2name = N'Updated'
GO


CREATE INDEX [IX_Person_LastName_FirstName] ON [dbo].[Person] ([LastName], [FirstName])
