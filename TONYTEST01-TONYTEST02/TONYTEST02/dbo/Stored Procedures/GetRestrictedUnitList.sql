
-- [GetRestrictedUnitList] is used to get all the restricted units of role
CREATE PROCEDURE [dbo].[GetRestrictedUnitList]
  (
  @User_Role_ID UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT ORGRES.organization_id
    FROM   dbo.cdr_restricted_organization AS ORGRES
           INNER JOIN int_organization AS ORG
             ON ORG.organization_id = ORGRES.organization_id
    WHERE  user_role_id = @User_Role_ID
  END


