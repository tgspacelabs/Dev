

-- [DeleteRole] is used to delete Role
CREATE PROCEDURE [dbo].[DeleteRole]
    (
     @role_Id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM
        [dbo].[int_user_role]
    WHERE
        [user_role_id] = @role_Id;

    DELETE FROM
        [dbo].[int_security]
    WHERE
        [user_role_id] = @role_Id
        AND [user_id] IS NULL;

    DELETE FROM
        [dbo].[int_user]
    WHERE
        [user_role_id] = @role_Id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Delete a User Role.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'DeleteRole';

