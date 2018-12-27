
CREATE PROCEDURE [dbo].[GetUnitsByFacility]
(
@facility_id DFACILITY_ID,
@login_name  NVARCHAR(64)
)
AS
SET NOCOUNT ON

BEGIN
SELECT int_organization.organization_nm AS UNIT_NAME,
       int_organization.organization_id AS UNIT_ID
FROM   int_organization
WHERE  int_organization.parent_organization_id = @facility_id
AND int_organization.category_cd = 'D' 
AND int_organization.organization_id NOT IN ( SELECT cdr_restricted_organization.organization_id
                                                FROM   cdr_restricted_organization
                                                WHERE  ( cdr_restricted_organization.user_role_id =
                                                ( SELECT user_role_id
                                                FROM   int_user
                                                WHERE  int_user.login_name = @login_name ) ) )
ORDER BY int_organization.organization_nm 
END
SET NOCOUNT OFF
