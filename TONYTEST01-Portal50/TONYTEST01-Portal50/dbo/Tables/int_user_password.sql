﻿CREATE TABLE [dbo].[int_user_password] (
    [user_id]   UNIQUEIDENTIFIER NOT NULL,
    [password]  NVARCHAR (40)    NOT NULL,
    [change_dt] DATETIME         NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [user_password_idx]
    ON [dbo].[int_user_password]([user_id] ASC, [password] ASC, [change_dt] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains password history for users whenever they change their password. It is only used if the security option to keep password history has been enabled. It stores previous passwords to prevent users from re-using a password within a certain number of times. The current password for a user is NOT stored in this table (only prior values).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_user_password';
