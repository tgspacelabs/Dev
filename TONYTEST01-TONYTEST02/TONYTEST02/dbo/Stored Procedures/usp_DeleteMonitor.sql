CREATE PROCEDURE [dbo].[usp_DeleteMonitor]
(
@monitor_id UNIQUEIDENTIFIER
)
as
begin
	DELETE int_monitor WHERE monitor_id = @monitor_id
end

