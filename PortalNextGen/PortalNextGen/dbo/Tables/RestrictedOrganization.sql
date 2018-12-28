CREATE TABLE [dbo].[RestrictedOrganization] (
    [RestrictedOrganizationID] INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationID]           INT           NOT NULL,
    [RoleID]                   INT           NOT NULL,
    [CreatedDateTime]          DATETIME2 (7) CONSTRAINT [DF_RestrictedOrganization_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_RestrictedOrganization_RestrictedOrganizationID] PRIMARY KEY CLUSTERED ([RestrictedOrganizationID] ASC),
    CONSTRAINT [FK_RestrictedOrganization_Role_RoleID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_RestrictedOrganization_OrganizationID_UserRoleID]
    ON [dbo].[RestrictedOrganization]([OrganizationID] ASC, [RoleID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_RestrictedOrganization_Role_RoleID]
    ON [dbo].[RestrictedOrganization]([RoleID] ASC);

