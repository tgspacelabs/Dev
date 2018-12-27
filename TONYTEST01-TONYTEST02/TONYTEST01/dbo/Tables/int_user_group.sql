CREATE TABLE [dbo].[int_user_group] (
    [user_group_id] UNIQUEIDENTIFIER NOT NULL,
    [group_name]    NVARCHAR (10)    NOT NULL,
    [group_descr]   NVARCHAR (50)    NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [user_group_pk]
    ON [dbo].[int_user_group]([user_group_id] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [user_group_name]
    ON [dbo].[int_user_group]([group_name] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table defines the groups that are available for user groups. Each user can be a member of zero, one or multiple user groups. Users are assigned to groups to allow coverage or access to the practicing lists of the other members in the group. It is used for any "clinical grouping" that needs to occur for each application and is somewhat application defined.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_user_group';

