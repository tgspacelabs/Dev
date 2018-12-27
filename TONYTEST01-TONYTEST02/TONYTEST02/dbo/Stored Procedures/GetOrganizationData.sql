
-- [GetHierarchicalOrgs] is used to get organization structure
CREATE PROCEDURE [dbo].[GetOrganizationData]
AS
  BEGIN
    SELECT ORG.organization_id,
           ORG.category_cd,
           ORG.parent_organization_id,
           ORG.organization_cd,
           ORG.organization_nm
    FROM   int_organization AS ORG
    ORDER  BY category_cd DESC
  END


