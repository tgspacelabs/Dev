CREATE TABLE [dbo].[int_user_group_member] (
    [user_group_id] BIGINT NOT NULL,
    [user_id]       BIGINT NOT NULL,
    CONSTRAINT [PK_int_user_group_member_user_id_user_group_id] PRIMARY KEY CLUSTERED ([user_id] ASC, [user_group_id] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_int_user_group_member_int_user_user_id] FOREIGN KEY ([user_id]) REFERENCES [dbo].[int_user] ([user_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the members of a user group. Each user can be a member of zero, one or multiple groups.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_user_group_member';

