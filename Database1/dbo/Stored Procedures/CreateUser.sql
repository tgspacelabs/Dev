
/*[CreateUser] Procedure is used to assign role for user*/
CREATE PROCEDURE [dbo].[CreateUser]
    (
     @user_role_id UNIQUEIDENTIFIER,
     @login_name NVARCHAR(64)
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @user_id UNIQUEIDENTIFIER = NEWID( );

    INSERT  [dbo].[int_user]
            ([user_id],
             [user_role_id],
             [user_sid],
             [login_name]
            )
    VALUES
            (@user_id,
             @user_role_id,
             NULL,
             @login_name
            );

    SELECT
        @user_id AS [USERID];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Create user and assign a role for the user.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'CreateUser';

