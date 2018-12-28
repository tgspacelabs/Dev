CREATE TABLE [dbo].[SecurityDifference] (
    [SecurityDifferenceID] INT            IDENTITY (1, 1) NOT NULL,
    [UserID]               INT            NULL,
    [RoleID]               INT            NULL,
    [NodePath]             NVARCHAR (255) NOT NULL,
    [ChangedAtGlobal]      TINYINT        NULL,
    [CreatedDateTime]      DATETIME2 (7)  CONSTRAINT [DF_SecurityDifference_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SecurityDifference_SecurityDifferenceID] PRIMARY KEY CLUSTERED ([SecurityDifferenceID] ASC),
    CONSTRAINT [FK_SecurityDifference_Role_RoleID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SecurityDifference_UserRoleID_NodePath_UserID_ChangedAtGlobal]
    ON [dbo].[SecurityDifference]([RoleID] ASC, [NodePath] ASC, [UserID] ASC, [ChangedAtGlobal] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SecurityDifference_User_UserID]
    ON [dbo].[SecurityDifference]([UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SecurityDifference_Role_RoleID]
    ON [dbo].[SecurityDifference]([RoleID] ASC);

