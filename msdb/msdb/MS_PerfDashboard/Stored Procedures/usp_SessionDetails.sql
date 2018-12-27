create procedure MS_PerfDashboard.usp_SessionDetails @include_system_processes bit
as
begin
	select session_id,
		login_name,
		host_name,
		program_name,
		nt_domain,
		nt_user_name,
		status,
		cpu_time,
		memory_usage,
		last_request_start_time,
		last_request_end_time,
		logical_reads,
		reads,
		writes,
		is_user_process
	from sys.dm_exec_sessions s
	WHERE s.is_user_process = CASE when @include_system_processes > 0 THEN s.is_user_process ELSE 1 END
end
