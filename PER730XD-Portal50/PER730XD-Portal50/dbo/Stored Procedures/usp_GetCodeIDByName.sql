create proc [dbo].[usp_GetCodeIDByName]
(
@short_dsc NVARCHAR(100)
)
as
begin
    SELECT 
    code_id 
    FROM 
    int_misc_code 
    WHERE 
    short_dsc = @short_dsc
end
