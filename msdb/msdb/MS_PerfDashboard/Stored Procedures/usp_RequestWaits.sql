create procedure MS_PerfDashboard.usp_RequestWaits
as
begin
	select r.session_id, 
		r.request_id, 
		master.dbo.fn_varbintohexstr(r.sql_handle) as sql_handle, 
		master.dbo.fn_varbintohexstr(r.plan_handle) as plan_handle, 
		case when LEN(qt.query_text) < 2048 then qt.query_text else LEFT(qt.query_text, 2048) + N'...' end as query_text,
		r.statement_start_offset,
		r.statement_end_offset,
		r.wait_time, 
		r.wait_type, 
		r.wait_resource,
		msdb.MS_PerfDashboard.fn_WaitTypeCategory(wait_type) as wait_category
	from sys.dm_exec_requests r
		join sys.dm_exec_sessions s on r.session_id = s.session_id
		outer apply msdb.MS_PerfDashboard.fn_QueryTextFromHandle(r.sql_handle, r.statement_start_offset, r.statement_end_offset) as qt
	where r.wait_type is not null and s.is_user_process = 0x1
end
