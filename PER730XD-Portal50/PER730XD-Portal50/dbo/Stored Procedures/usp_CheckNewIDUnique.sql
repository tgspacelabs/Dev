create proc [dbo].[usp_CheckNewIDUnique]
(
@value int
)
as
begin
    SELECT 
    COUNT(*) 
    AS 
    TotalCount 
    FROM 
    int_misc_code 
    WHERE 
    code_id = @value
end
