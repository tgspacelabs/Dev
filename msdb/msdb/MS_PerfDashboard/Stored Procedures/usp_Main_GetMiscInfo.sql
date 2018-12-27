
create procedure MS_PerfDashboard.usp_Main_GetMiscInfo
as
begin
	select 
		(select count(*) from sys.traces) as running_traces,
		(select count(*) from sys.databases) as number_of_databases,
		(select count(*) from sys.dm_db_missing_index_group_stats) as missing_index_count,
		(select waiting_tasks_count from sys.dm_os_wait_stats where wait_type = N'SQLCLR_QUANTUM_PUNISHMENT') as clr_quantum_waits,
		(select count(*) from sys.dm_os_ring_buffers where ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR' and record like N'%<NonYieldSchedBegin>%') as non_yield_count,
		(select cpu_count from sys.dm_os_sys_info) as number_of_cpus,
		(select scheduler_count from sys.dm_os_sys_info) as number_of_schedulers,
		(select COUNT(*) from sys.dm_xe_sessions) as number_of_xevent_sessions,
		(select convert(varchar(30), AttribValue) from MS_PerfDashboard.tblConfigValues where Attribute = 'ReportVersion') as report_script_version
	end
