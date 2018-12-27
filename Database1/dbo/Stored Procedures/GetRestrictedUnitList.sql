

-- [GetRestrictedUnitList] is used to get all the restricted units of role
CREATE PROCEDURE [dbo].[GetRestrictedUnitList]
    (
     @User_Role_ID UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [ORGRES].[organization_id]
    FROM
        [dbo].[cdr_restricted_organization] AS [ORGRES]
        INNER JOIN [dbo].[int_organization] AS [ORG] ON [ORG].[organization_id] = [ORGRES].[organization_id]
    WHERE
        [ORGRES].[user_role_id] = @User_Role_ID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get all the restricted units of role.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetRestrictedUnitList';

