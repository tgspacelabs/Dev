create procedure MS_PerfDashboard.usp_SessionRequests @session_id int
as
begin
	select request_id, 
		master.dbo.fn_varbintohexstr(sql_handle) as sql_handle,
		master.dbo.fn_varbintohexstr(plan_handle) as plan_handle,
		statement_start_offset, 
		statement_end_offset,
		qt.query_text,
		start_time,
		status,
		command,
		r.database_id,
		blocking_session_id,
		wait_type,
		wait_time,
		wait_resource,
		cpu_time,
		total_elapsed_time,
		open_transaction_count,
		transaction_id,
		logical_reads,
		reads,
		writes
	from sys.dm_exec_requests r
		outer apply msdb.MS_PerfDashboard.fn_QueryTextFromHandle(sql_handle, statement_start_offset, statement_end_offset) as qt
	where session_id = @session_id
end
