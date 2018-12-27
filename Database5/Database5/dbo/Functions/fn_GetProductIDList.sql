
CREATE FUNCTION [dbo].[fn_GetProductIDList]
(
	@SalesOrderID INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @product_ids NVARCHAR(MAX);

	SELECT @product_ids = STUFF((
								SELECT ',' + CAST(ProductID AS VARCHAR)
								FROM Sales.SalesOrderDetailEnlarged AS sod
								WHERE SalesOrderID = @SalesOrderID
								FOR XML PATH(''))
								,1,1,'') 

	RETURN @product_ids;
END
