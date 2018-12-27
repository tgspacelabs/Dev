create proc [dbo].[usp_CEI_GetLicenseUnits]
as
	begin
		SELECT 
		int_organization.organization_cd
		FROM int_organization 
		INNER JOIN 
		int_product_access 
		ON 
		int_organization.organization_id = int_product_access.organization_id
		WHERE int_product_access.product_cd = 'cei'
	end
