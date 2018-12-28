CREATE TABLE [dbo].[Preference] (
    [PreferenceID]    INT             IDENTITY (1, 1) NOT NULL,
    [UserID]          INT             NULL,
    [RoleID]          INT             NULL,
    [ApplicationID]   NCHAR (3)       NULL,
    [XmlData]         VARBINARY (MAX) NOT NULL,
    [CreatedDateTime] DATETIME2 (7)   CONSTRAINT [DF_Preference_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Preference_PreferenceID] PRIMARY KEY CLUSTERED ([PreferenceID] ASC),
    CONSTRAINT [FK_Preference_Role_RoleID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Preference_UserID_UserRoleID]
    ON [dbo].[Preference]([UserID] ASC, [RoleID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Preference_User_UserID]
    ON [dbo].[Preference]([UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Preference_Role_RoleID]
    ON [dbo].[Preference]([RoleID] ASC);

