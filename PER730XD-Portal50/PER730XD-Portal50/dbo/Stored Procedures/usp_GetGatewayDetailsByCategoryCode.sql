create proc [dbo].[usp_GetGatewayDetailsByCategoryCode]
(
@categoryCode char(1) = null,
@parentOrganizationId UNIQUEIDENTIFIER=null
)
as
begin

if @parentOrganizationId is null
        begin
            select * 
            from 
            int_organization
            where 
            category_cd = @categoryCode
            ORDER BY category_cd 
        end
else
        begin        
            select * 
            from 
            int_organization
            where 
            category_cd =@categoryCode
            and 
            parent_organization_id = @parentOrganizationId
            ORDER BY 
            category_cd 
        end
    
end
