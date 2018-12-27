create procedure MS_PerfDashboard.usp_SessionRequestActivity @WithActivitySince datetime, @IsUserProcess bit
as
begin
	select avg_request_cpu_per_ms * request_ms_in_window as request_recent_cpu_est,
		avg_session_cpu_per_ms * session_ms_in_window as session_recent_cpu_est,
		d.*
	from (select s.session_id,
		r.request_id,
		s.login_time,
	--	s.host_name,
		s.program_name,
		s.login_name,
		s.status as session_status,
		s.last_request_start_time,
		s.last_request_end_time,
		s.cpu_time as session_cpu_time,
		r.cpu_time as request_cpu_time,
	--	s.logical_reads as session_logical_reads,
	--	r.logical_reads as request_logical_reads,
		r.start_time as request_start_time,
		r.status as request_status,
		r.command,
		master.dbo.fn_varbintohexstr(r.sql_handle) as sql_handle,
		master.dbo.fn_varbintohexstr(r.plan_handle) as plan_handle,
		r.statement_start_offset,
		r.statement_end_offset,
		case when r.start_time > getdate() then convert(float, r.cpu_time) / msdb.MS_PerfDashboard.fn_DatediffMilliseconds(r.start_time, getdate()) else convert(float, 1.0) end as avg_request_cpu_per_ms,
		isnull(msdb.MS_PerfDashboard.fn_DatediffMilliseconds(case when r.start_time < @WithActivitySince then @WithActivitySince else r.start_time end, getdate()), 0) as request_ms_in_window,
		case when s.login_time > getdate() then convert(float, s.cpu_time) / (msdb.MS_PerfDashboard.fn_DatediffMilliseconds(s.login_time, getdate())) else convert(float, 1.0) end as avg_session_cpu_per_ms,
		isnull(msdb.MS_PerfDashboard.fn_DatediffMilliseconds(case when s.login_time < @WithActivitySince then @WithActivitySince else s.login_time end, case when r.request_id is null then s.last_request_end_time else getdate() end), 0) as session_ms_in_window
	from sys.dm_exec_sessions s
		left join sys.dm_exec_requests as r on s.session_id = r.session_id
	where (s.last_request_end_time > @WithActivitySince or r.request_id is not null) and (s.is_user_process = @IsUserProcess or s.is_user_process=1)) as d
	where (avg_request_cpu_per_ms * request_ms_in_window) + (avg_session_cpu_per_ms * session_ms_in_window) > 1000.0
end
