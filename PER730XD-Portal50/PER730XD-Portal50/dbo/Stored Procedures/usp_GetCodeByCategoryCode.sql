 
 /*Gets code id by category code*/
CREATE PROCEDURE [dbo].[usp_GetCodeByCategoryCode]
(
@categoryCd char(4),
@MethodCd NVARCHAR(10),
@Code NVARCHAR(80),
@OrganizationId UNIQUEIDENTIFIER,
@SendingSysId UNIQUEIDENTIFIER,
@CodeId int out
)
AS
BEGIN
SET @CodeId=(SELECT 
MiscCode.code_id 
FROM int_misc_code AS MiscCode 
INNER JOIN int_code_category CodeCat 
    ON MiscCode.category_cd = CodeCat.cat_code 
WHERE 
(MiscCode.category_cd = @categoryCd) 
AND (MiscCode.code = @Code) 
AND (MiscCode.organization_id = @OrganizationId) 
AND MiscCode.sys_id = @SendingSysId
AND MiscCode.method_cd = @MethodCd)
END
