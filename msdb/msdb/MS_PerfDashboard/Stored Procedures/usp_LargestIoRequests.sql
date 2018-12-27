create procedure MS_PerfDashboard.usp_LargestIoRequests
as
begin
	select top 20 
		r.session_id,
		r.request_id, 
		master.dbo.fn_varbintohexstr(sql_handle) as sql_handle,
		master.dbo.fn_varbintohexstr(plan_handle) as plan_handle,
		case when LEN(qt.query_text) < 2048 then qt.query_text else LEFT(qt.query_text, 2048) + N'...' end as query_text,
		r.statement_start_offset, 
		r.statement_end_offset, 
		r.logical_reads,
		r.reads,
		r.writes,
		r.wait_type, 
		r.wait_time, 
		r.wait_resource,
		r.blocking_session_id,
		case when r.logical_reads > 0 then (r.logical_reads - isnull(r.reads, 0)) / convert(float, r.logical_reads)
			else NULL
			end as cache_hit_ratio
	from sys.dm_exec_requests r
		join sys.dm_exec_sessions s on r.session_id = s.session_id
		outer apply msdb.MS_PerfDashboard.fn_QueryTextFromHandle(r.sql_handle, r.statement_start_offset, r.statement_end_offset) as qt
	where s.is_user_process = 0x1 and (r.reads > 0 or r.writes > 0)
	order by (r.reads + r.writes) desc
end
