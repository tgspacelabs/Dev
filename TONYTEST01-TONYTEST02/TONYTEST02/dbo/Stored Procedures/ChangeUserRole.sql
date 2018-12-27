
-- [ChangeUserRole]  is used to Change role for user
CREATE PROCEDURE [dbo].[ChangeUserRole]
  (
  @user_id      UNIQUEIDENTIFIER,
  @user_role_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    UPDATE int_user
    SET    user_role_Id = @user_role_id
    WHERE  user_id = @user_id
  END


