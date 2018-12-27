 
/*usp_GetUnitLicense-Get Unit license by Unit Code Or Unit Id*/
CREATE PROCEDURE [dbo].[usp_Hl7_GetUnitLicense]
(
	@productcd varchar(25),
	@categoryCd Char(1),
	@organizationId UNIQUEIDENTIFIER,
	@OrgCode NVARCHAR(20) out
)
AS
BEGIN
	SET @OrgCode=(SELECT 
	ORG.organization_cd
	FROM int_organization AS ORG
	INNER JOIN int_product_access AS PROACC
		ON PROACC.organization_id=ORG.organization_id 
	WHERE PROACC.product_cd=@productCd
	AND ORG.Category_cd=@categoryCd 
	AND Org.organization_id = @organizationId)
END
