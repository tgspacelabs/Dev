create proc [dbo].[usp_GetAllProducts]
as
begin
    select * from int_product ORDER BY product_cd
end
