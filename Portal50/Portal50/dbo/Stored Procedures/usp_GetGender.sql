create proc [dbo].[usp_GetGender]

as
begin
	SELECT short_dsc FROM int_misc_code WHERE category_cd = 'SEX' and verification_sw = '1'
end
