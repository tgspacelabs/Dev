
/*usp_GetUnitLicense-Get Unit license by Unit Code Or Unit Id*/
CREATE PROCEDURE [dbo].[usp_GetUnitLicense]
(
@productcd varchar(25),
@categoryCd Char(1),
@organizationId UNIQUEIDENTIFIER,
@organizationCd NVARCHAR(40)=NULL
)
AS
BEGIN
	IF(@organizationCd IS NOT NULL)
		BEGIN
			SELECT 
			ORG.organization_cd AS ORGCD
			FROM int_organization AS ORG
			INNER JOIN int_product_access AS PROACC
				ON PROACC.organization_id=ORG.organization_id 
			WHERE PROACC.product_cd=@productCd
			AND ORG.Category_cd=@categoryCd 
			AND (Org.organization_id = @organizationId AND Org.organization_cd = @organizationCd)
		END
	ELSE
		BEGIN
		 SELECT 
			ORG.organization_cd AS ORGCD
			FROM int_organization AS ORG
			INNER JOIN int_product_access AS PROACC
				ON PROACC.organization_id=ORG.organization_id 
			WHERE PROACC.product_cd=@productCd
			AND ORG.Category_cd=@categoryCd 
			AND Org.organization_id = @organizationId
		END
END

