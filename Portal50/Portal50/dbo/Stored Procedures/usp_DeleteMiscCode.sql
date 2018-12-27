create proc [dbo].[usp_DeleteMiscCode]
(
@code_id int
)
as
begin
	DELETE int_misc_code WHERE code_id = @code_id
end
