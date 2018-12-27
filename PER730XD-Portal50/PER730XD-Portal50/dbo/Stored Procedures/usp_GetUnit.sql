CREATE PROCEDURE [dbo].[usp_GetUnit]
  
AS
  BEGIN
      SELECT
      int_organization_1.organization_cd + ' - ' + int_organization.organization_cd,
      int_organization.organization_nm, 
      int_organization.organization_id,
      int_organization.parent_organization_id,
      int_organization.organization_cd 
      FROM 
      int_organization 
      INNER JOIN int_organization AS int_organization_1 
      ON int_organization.parent_organization_id = int_organization_1.organization_id 
      WHERE 
      (int_organization.category_cd = 'D')
  end
