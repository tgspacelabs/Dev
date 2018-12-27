
-- [DeleteRestrictedUnits] is used to delete all the restricted organizations based on roleId
CREATE PROCEDURE DeleteRestricteDunIts
  (
  @user_role_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    DELETE FROM cdr_restricted_organization
    WHERE  user_role_id = @user_role_id;
  END

