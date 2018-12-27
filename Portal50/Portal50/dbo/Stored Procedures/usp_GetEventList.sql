create proc [dbo].[usp_GetEventList]

as
begin
	SELECT 
	code,
	short_dsc 
	FROM 
	int_misc_code 
	WHERE 
	category_cd = 'SLOG'
end
