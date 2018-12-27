﻿
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


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Testing the description setting of the stored procedure', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'CreateRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description-TEST', @value = N'This is a test parameter description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'CreateRole';
