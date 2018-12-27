create procedure MS_PerfDashboard.usp_LatchStats
as
begin
	select 
		latch_class,
		waiting_requests_count,
		wait_time_ms,
		max_wait_time_ms
	from sys.dm_os_latch_stats
	where waiting_requests_count > 0
end
