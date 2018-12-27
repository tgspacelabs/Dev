
-- [DeleteUser] is used to delete ICS user by user_id
CREATE PROCEDURE [dbo].[DeleteUser]
  (
  @user_Id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    DELETE FROM int_user
    WHERE  user_id = @user_Id;

    DELETE FROM int_security
    WHERE  user_id = @user_Id;
  END


