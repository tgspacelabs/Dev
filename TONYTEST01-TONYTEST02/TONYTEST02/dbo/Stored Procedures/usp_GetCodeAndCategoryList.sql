CREATE PROCEDURE [dbo].[usp_GetCodeAndCategoryList]

as
begin
	SELECT cat_code FROM int_code_category ORDER BY cat_code
end

