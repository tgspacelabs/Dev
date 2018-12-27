
create procedure MS_PerfDashboard.usp_Main_GetSessionInfo
as
begin
	select count(*) as num_sessions,
		sum(convert(bigint, s.total_elapsed_time)) as total_elapsed_time,
		sum(convert(bigint, s.cpu_time)) as cpu_time, 
		case when sum(convert(bigint, s.total_elapsed_time)) - sum(convert(bigint, s.cpu_time)) > 0
			then sum(convert(bigint, s.total_elapsed_time)) - sum(convert(bigint, s.cpu_time))
			else 0
		end as wait_time,
		sum(convert(bigint, MS_PerfDashboard.fn_DatediffMilliseconds(login_time, getdate()))) - sum(convert(bigint, s.total_elapsed_time)) as idle_connection_time,
		case when sum(s.logical_reads) > 0 then (sum(s.logical_reads) - isnull(sum(s.reads), 0)) / convert(float, sum(s.logical_reads))
			else NULL
			end as cache_hit_ratio
	from sys.dm_exec_sessions s
	where s.is_user_process = 0x1
end
