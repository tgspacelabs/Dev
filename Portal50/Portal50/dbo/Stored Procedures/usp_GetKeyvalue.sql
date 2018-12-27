create proc [dbo].[usp_GetKeyvalue]
(
@keyname varchar(40)
)
as
begin
	SELECT 
	keyvalue 
	FROM 
	int_cfg_values 
	WHERE 
	keyname = @keyname
end
