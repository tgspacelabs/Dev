CREATE TABLE [dbo].[Password] (
    [PasswordID]       INT           IDENTITY (1, 1) NOT NULL,
    [UserID]           INT           NOT NULL,
    [Password]         NVARCHAR (40) NOT NULL,
    [CreatedDateTime]  DATETIME2 (7) CONSTRAINT [DF_UserPassword_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [ModifiedDateTime] DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Password_PasswordID] PRIMARY KEY CLUSTERED ([PasswordID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_UserPassword_UserID_Password_ModifiedDateTime]
    ON [dbo].[Password]([UserID] ASC, [Password] ASC, [ModifiedDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Password_User_UserID]
    ON [dbo].[Password]([UserID] ASC);

