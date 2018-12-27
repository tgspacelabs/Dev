 CREATE PROCEDURE [dbo].[usp_DM3_GetproductAccessDetails]
 (
	@Product	NVARCHAR(30)
 )
AS
 BEGIN
	select * from int_product_access where product_cd  = @Product
 END
