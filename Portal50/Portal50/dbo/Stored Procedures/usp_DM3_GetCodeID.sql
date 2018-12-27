CREATE PROCEDURE [dbo].[usp_DM3_GetCodeID]
 AS
 BEGIN
 select code_id, code FROM int_misc_code WHERE (organization_id IS NULL)  AND (code IS NOT NULL)
 END
