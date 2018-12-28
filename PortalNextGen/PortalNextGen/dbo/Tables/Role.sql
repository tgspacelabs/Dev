CREATE TABLE [dbo].[Role] (
    [RoleID]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (32)  NOT NULL,
    [Description]      NVARCHAR (255) NULL,
    [CreatedDateTime]  DATETIME2 (7)  CONSTRAINT [DF_Role_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [ModifiedDateTime] DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_Role_RoleID] PRIMARY KEY CLUSTERED ([RoleID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Role_Name]
    ON [dbo].[Role]([Name] ASC);

