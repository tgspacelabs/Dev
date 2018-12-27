create procedure MS_PerfDashboard.usp_SessionData @session_id int
as
begin
	SELECT session_id, login_time, host_name, program_name, login_name, nt_domain, 
						  nt_user_name, status, cpu_time, memory_usage, total_scheduled_time, total_elapsed_time, last_request_start_time, 
						  last_request_end_time, reads, writes, logical_reads, is_user_process, text_size, language, date_format, date_first, quoted_identifier, arithabort, 
						  ansi_null_dflt_on, ansi_defaults, ansi_warnings, ansi_padding, ansi_nulls, concat_null_yields_null, transaction_isolation_level, lock_timeout, 
						  deadlock_priority, row_count, prev_error
	FROM sys.dm_exec_sessions
	WHERE session_id = @session_id
end
