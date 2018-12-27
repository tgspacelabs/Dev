
-- [GetAccessSettings] is used to retrieve the security settings of a Role
CREATE PROCEDURE [dbo].[GetAccessSettings]
  (
  @role_Id UNIQUEIDENTIFIER
  )
AS
  IF @role_Id IS NULL
    BEGIN
      SELECT xml_data
      FROM   INT_SECURITY
      WHERE  user_role_id IS NULL AND User_Id IS NULL;
    END
  ELSE
    BEGIN
      SELECT xml_data
      FROM   INT_SECURITY
      WHERE  user_role_id = @role_Id AND User_Id IS NULL;
    END

