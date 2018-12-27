CREATE TABLE [dbo].[int_user] (
    [user_id]      UNIQUEIDENTIFIER NOT NULL,
    [user_role_id] UNIQUEIDENTIFIER NOT NULL,
    [user_sid]     NVARCHAR (68)    NULL,
    [hcp_id]       UNIQUEIDENTIFIER NULL,
    [login_name]   NVARCHAR (64)    NULL,
    PRIMARY KEY CLUSTERED ([user_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [user_tbl_ndx1]
    ON [dbo].[int_user]([user_role_id] ASC);


GO
CREATE NONCLUSTERED INDEX [user_tbl_ndx2]
    ON [dbo].[int_user]([user_sid] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [user_tbl_ndx3]
    ON [dbo].[int_user]([login_name] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The USER_TBL contains an entry for every user of the Intesys products. All Intesys modules that share the common schema will use the same user record regardless of what modules a user has access.Entries in this table are managed by user role administration module in ICS Admin', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_user';

