


/*[CreateUser] Procedure is used to assign role for user*/
CREATE PROCEDURE [dbo].[CreateUser]
  (
  @user_role_id UNIQUEIDENTIFIER,
  @login_name   NVARCHAR(64)
  )
AS
  BEGIN
    DECLARE @user_id UNIQUEIDENTIFIER

    SET @user_id = NewId( )

    INSERT int_user
           (user_id,
            user_role_id,
            user_sid,
            login_name)
    VALUES(@user_id,
           @user_role_id,
           NULL,
           @login_name)

    SELECT @user_id AS USERID
  END


