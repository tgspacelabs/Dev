create procedure MS_PerfDashboard.usp_RequestDetails @include_system_processes bit
as
begin
	SELECT master.dbo.fn_varbintohexstr(sql_handle) AS sql_handle,  
		master.dbo.fn_varbintohexstr(plan_handle) AS plan_handle, 
		case when LEN(qt.query_text) < 2048 then qt.query_text else LEFT(qt.query_text, 2048) + N'...' end as query_text,
		r.session_id,
		r.request_id,
		r.start_time,
		r.status,
		r.statement_start_offset,
		r.statement_end_offset,
		r.database_id,
		r.blocking_session_id,
		r.wait_type,
		r.wait_time,
		r.wait_resource,
		r.last_wait_type,
		r.open_transaction_count,
		r.open_resultset_count,
		r.transaction_id,
		r.cpu_time,
		r.total_elapsed_time,
		r.scheduler_id,
		r.reads,
		r.writes,
		r.logical_reads,
		r.transaction_isolation_level,
		r.granted_query_memory,
		r.executing_managed_code
	FROM sys.dm_exec_requests AS r
		JOIN sys.dm_exec_sessions s on r.session_id = s.session_id
		outer APPLY msdb.MS_PerfDashboard.fn_QueryTextFromHandle(sql_handle, statement_start_offset, statement_end_offset) as qt
	WHERE s.is_user_process = CASE when @include_system_processes > 0 THEN s.is_user_process ELSE 1 END
end
