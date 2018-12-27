create procedure MS_PerfDashboard.usp_QueryStatsDetails @query_hash varchar(64), @OrderBy_Criteria nvarchar(128)
as
begin
	select TOP 50
		db_name(qt.database_id) as database_name,
		qt.query_text,
		qt.encrypted,
		creation_time,
		last_execution_time,
		execution_count,
		plan_generation_num,
		total_worker_time,
		last_worker_time,
		min_worker_time,
		max_worker_time,
		total_physical_reads,
		last_physical_reads,
		min_physical_reads,
		max_physical_reads,
		total_logical_reads,
		last_logical_reads,
		min_logical_reads,
		max_logical_reads,
		total_logical_writes,
		last_logical_writes,
		min_logical_writes,
		max_logical_writes,
		total_clr_time,
		last_clr_time,
		min_clr_time,
		max_clr_time,
		total_elapsed_time,
		last_elapsed_time,
		min_elapsed_time,
		max_elapsed_time,
		master.dbo.fn_varbintohexstr(sql_handle) as sql_handle,
		master.dbo.fn_varbintohexstr(plan_handle) as plan_handle,
		statement_start_offset,
		statement_end_offset,
		CASE @OrderBy_Criteria 
							 WHEN 'Logical Reads' THEN total_logical_reads
							 WHEN 'Physical Reads' THEN total_physical_reads
							 WHEN 'Logical Writes' THEN total_logical_writes
							 WHEN 'CPU' THEN total_worker_time / 1000 
							 WHEN 'Duration' THEN total_elapsed_time / 1000 
							 WHEN 'CLR Time' THEN total_clr_time/ 1000 
			END as sort_value
	from sys.dm_exec_query_stats qs
	 cross apply msdb.MS_PerfDashboard.fn_QueryTextFromHandle(sql_handle, statement_start_offset, statement_end_offset) qt
	where query_hash = MS_PerfDashboard.fn_hexstrtovarbin(@query_hash)
	order by sort_value desc
end
