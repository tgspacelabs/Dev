CREATE TABLE [dbo].[PreferenceDifference] (
    [PreferenceDifferenceID] INT            IDENTITY (1, 1) NOT NULL,
    [UserID]                 INT            NULL,
    [RoleID]                 INT            NULL,
    [NodePath]               NVARCHAR (255) NOT NULL,
    [ChangedAtGlobal]        TINYINT        NULL,
    [CreatedDateTime]        DATETIME2 (7)  CONSTRAINT [DF_PreferenceDifference_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PreferenceDifference_PreferenceDifferenceID] PRIMARY KEY CLUSTERED ([PreferenceDifferenceID] ASC),
    CONSTRAINT [FK_PreferenceDifference_Role_RoleID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PreferenceDifference_UserRoleID_NodePath_UserID_ChangedAtGlobal]
    ON [dbo].[PreferenceDifference]([RoleID] ASC, [NodePath] ASC, [UserID] ASC, [ChangedAtGlobal] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PreferenceDifference_User_UserID]
    ON [dbo].[PreferenceDifference]([UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PreferenceDifference_Role_RoleID]
    ON [dbo].[PreferenceDifference]([RoleID] ASC);

