
-- [AssignUserRole] is used to assign role for user
CREATE PROCEDURE [dbo].[AssignUserRole]
    (
     @user_id UNIQUEIDENTIFIER,
     @user_role_id UNIQUEIDENTIFIER,
     @user_sid NVARCHAR(68),
     @login_name NVARCHAR(64)
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  [dbo].[int_user]
            ([user_id],
             [user_role_id],
             [user_sid],
             [login_name]
            )
    VALUES  (@user_id,
             @user_role_id,
             @user_sid,
             @login_name
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Assign role for user.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'AssignUserRole';

