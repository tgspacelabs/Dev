CREATE PROCEDURE [dbo].[usp_DeleteSendSys]
(
@sys_id UNIQUEIDENTIFIER
)
as
begin
	DELETE int_send_sys WHERE sys_id =@sys_id 
end

