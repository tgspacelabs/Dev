create procedure MS_PerfDashboard.usp_RequestIoWaits @wait_type nvarchar(128)
as
begin
	select 
		session_id, 
		request_id, 
		master.dbo.fn_varbintohexstr(sql_handle) as sql_handle,
		master.dbo.fn_varbintohexstr(plan_handle) as plan_handle,
		case when LEN(qt.query_text) < 2048 then qt.query_text else LEFT(qt.query_text, 2048) + N'...' end as query_text,
		statement_start_offset, 
		statement_end_offset, 
		wait_type, 
		wait_time, 
		wait_resource,
		blocking_session_id
	from sys.dm_exec_requests r
		outer apply msdb.MS_PerfDashboard.fn_QueryTextFromHandle(sql_handle, statement_start_offset, statement_end_offset) as qt
	where msdb.MS_PerfDashboard.fn_WaitTypeCategory(wait_type) = @wait_type --N'Buffer IO'/N'Buffer Latch'
end
