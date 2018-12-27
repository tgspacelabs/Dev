

-- [DeleteUser] is used to delete ICS user by user_id
CREATE PROCEDURE [dbo].[DeleteUser]
    (
     @user_Id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM
        [dbo].[int_user]
    WHERE
        [user_id] = @user_Id;

    DELETE FROM
        [dbo].[int_security]
    WHERE
        [user_id] = @user_Id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Delete ICS user by user ID.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'DeleteUser';

