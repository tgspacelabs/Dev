create procedure MS_PerfDashboard.usp_DmOsWaitStats
as
begin
	select 
	wait_type, 
	msdb.MS_PerfDashboard.fn_WaitTypeCategory(wait_type) as wait_category,
	waiting_tasks_count as num_waits, 
	wait_time_ms as wait_time,
	max_wait_time_ms
	from sys.dm_os_wait_stats
	where waiting_tasks_count > 0
end
