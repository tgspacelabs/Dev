create proc [dbo].[usp_Delete_OrganizationEntityByCategory]
(
@organization_id UNIQUEIDENTIFIER,
@category_Code char(1)
)
as
begin
	DELETE 
	int_organization  
	WHERE 
	organization_id = @organization_id
		AND
	category_cd = @category_Code
end

