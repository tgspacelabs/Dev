create proc [dbo].[usp_GetAllProducts]
as
begin
	select * from int_product order by product_cd
end
