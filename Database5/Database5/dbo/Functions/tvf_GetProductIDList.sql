
CREATE FUNCTION [dbo].[tvf_GetProductIDList]
(
	@SalesOrderID INT
)
RETURNS TABLE
AS RETURN
(
	SELECT ProductIDList = STUFF((
						SELECT ',' + CAST(ProductID AS VARCHAR)
						FROM Sales.SalesOrderDetailEnlarged AS sod
						WHERE SalesOrderID = @SalesOrderID
						FOR XML PATH(''))
						,1,1,'')        
)

