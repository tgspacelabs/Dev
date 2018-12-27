
-- [CreateRole] is used to create a Role
CREATE PROCEDURE [dbo].[CreateRole]
  (
  @role_Id   UNIQUEIDENTIFIER,
  @role_Name VARCHAR(64),
  @role_Desc VARCHAR(510),
  @xml_data  XML
  )
AS
  BEGIN
    INSERT int_user_role
           (user_role_id,
            Role_name,
            Role_desc)
    VALUES(@role_Id,
           @role_Name,
           @role_Desc);

    INSERT int_security
           (user_role_id,
            xml_data)
    VALUES (@role_Id,
            @xml_data);
  END


