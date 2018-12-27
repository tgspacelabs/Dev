create proc [dbo].[usp_GetSelectedProducts]
(
@product_cd varchar(25)
)
as
begin
	select 
                                                    int_organization.* 
                                                    from 
                                                    int_product_access,
                                                    int_organization 
                                                    where 
                                                    int_product_access.organization_id = int_organization.organization_id 
                                                    and 
                                                    int_product_access.product_cd = @product_cd
                                                    order by
                                                    organization_nm
end
