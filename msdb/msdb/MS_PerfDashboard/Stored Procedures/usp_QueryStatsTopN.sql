create procedure MS_PerfDashboard.usp_QueryStatsTopN @OrderBy_Criteria nvarchar(128)
as
begin
	select 
		query_rank,
		charted_value,
		master.dbo.fn_varbintohexstr(sql_handle) as sql_handle,
		master.dbo.fn_varbintohexstr(plan_handle) as plan_handle,
		statement_start_offset,
		statement_end_offset,
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
		case when LEN(qt.query_text) < 2048 then qt.query_text else LEFT(qt.query_text, 2048) + N'...' end as query_text
	from (select s.*, row_number() over(order by charted_value desc, last_execution_time desc) as query_rank from
			 (select *, 
					CASE @OrderBy_Criteria
						WHEN 'Logical Reads' then total_logical_reads
						WHEN 'Physical Reads' then total_physical_reads
						WHEN 'Logical Writes' then total_logical_writes
						WHEN 'CPU' then total_worker_time / 1000
						WHEN 'Duration' then total_elapsed_time / 1000
						WHEN 'CLR Time' then total_clr_time / 1000
					END as charted_value 
				from sys.dm_exec_query_stats) as s where s.charted_value > 0) as qs
		cross apply msdb.MS_PerfDashboard.fn_QueryTextFromHandle(sql_handle, statement_start_offset, statement_end_offset) as qt
	where qs.query_rank <= 20     -- return only top 20 entries
end
