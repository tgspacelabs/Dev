
-- [DeleteRole] is used to delete Role
CREATE PROCEDURE [dbo].[DeleteRole]
  (
  @role_Id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    DELETE FROM int_user_role
    WHERE  user_role_id = @role_Id;

    DELETE FROM int_security
    WHERE  user_role_id = @role_Id AND user_id IS NULL;

    DELETE FROM int_user
    WHERE  user_role_id = @role_Id;
  END

