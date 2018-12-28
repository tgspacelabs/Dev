CREATE TABLE [dbo].[Security] (
    [SecurityID]      INT           IDENTITY (1, 1) NOT NULL,
    [UserID]          INT           NOT NULL,
    [RoleID]          INT           NOT NULL,
    [ApplicationID]   NCHAR (3)     NOT NULL,
    [XmlData]         XML           NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Security_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Security_SecurityID] PRIMARY KEY CLUSTERED ([SecurityID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Security_UserID_RoleID]
    ON [dbo].[Security]([UserID] ASC, [RoleID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Security_User_UserID]
    ON [dbo].[Security]([UserID] ASC);

