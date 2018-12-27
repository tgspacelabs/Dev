
-- [CreateRole] is used to create a Role
CREATE PROCEDURE [dbo].[CreateRole]
    (
     @role_Id UNIQUEIDENTIFIER,
     @role_Name VARCHAR(64),
     @role_Desc VARCHAR(510),
     @xml_data XML
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  [dbo].[int_user_role]
            ([user_role_id],
             [role_name],
             [role_desc]
            )
    VALUES  (@role_Id,
             @role_Name,
             @role_Desc
            );

    INSERT  [dbo].[int_security]
            ([user_role_id], [xml_data])
    VALUES  (@role_Id, @xml_data);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Create a role.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'CreateRole';

