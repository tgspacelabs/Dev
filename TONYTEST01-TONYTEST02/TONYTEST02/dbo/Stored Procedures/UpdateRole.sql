
-- [UpdateRole] is used to update Role
CREATE PROCEDURE [dbo].[UpdateRole]
  (
  @role_Id   UNIQUEIDENTIFIER,
  @role_name VARCHAR(50),
  @role_desc VARCHAR(250),
  @xml_data  XML
  )
AS
  BEGIN
    UPDATE int_user_role
    SET    Role_name = @role_name,
           Role_desc = @role_desc
    WHERE  user_role_id = @role_Id

    UPDATE int_security
    SET    xml_data = @xml_data
    WHERE  user_role_id = @role_Id

  END


