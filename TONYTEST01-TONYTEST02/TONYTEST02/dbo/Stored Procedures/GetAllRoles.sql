
-------------------------------------------------------------------------------------------------------------------------
-- procedures introduced for Security settings
-------------------------------------------------------------------------------------------------------------------------

-- [GetAllRoles] is used to get sLL Roles
CREATE PROCEDURE [dbo].[GetAllRoles]
AS
  BEGIN
    SELECT user_role_id,
           Role_name,
           Role_desc
    FROM   int_user_role;
  END


