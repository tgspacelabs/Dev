CREATE PROCEDURE [dbo].[usp_GetFacility]
as
begin
	SELECT 
                                            organization_cd, 
                                            organization_nm, 
                                            organization_id, 
                                            parent_organization_id 
                                            FROM int_organization
                                            WHERE category_cd = 'F'
end

