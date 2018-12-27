create proc [dbo].[usp_GetProductSecurity]
as
begin
select p.* 
            from 
            int_product_access p 
            inner join int_organization o 
                on p.organization_id = o.organization_id 
            where 
            o.category_cd = 'D'
end
