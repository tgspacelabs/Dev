create procedure MS_PerfDashboard.usp_QueryStatsTopN1 @OrderBy_Criteria nvarchar(128)
as
begin
	SELECT 
	query_text, 
	master.dbo.fn_varbintohexstr(query_hash) query_hash, 
	master.dbo.fn_varbintohexstr(sql_handle) sql_handle,
	statement_start_offset,
	statement_end_offset,
	querycount, 
	queryplanhashcount, 
	execution_count,
	total_elapsed_time,
	min_elapsed_time, 
	max_elapsed_time,
	average_elapsed_time,
	total_CPU_time, 
	min_CPU_time, 
	max_CPU_time, 
	average_CPU_time,
	total_logical_reads, 
	min_logical_reads, 
	max_logical_reads, 
	average_logical_reads,
	total_physical_reads, 
	min_physical_reads, 
	max_physical_reads, 
	average_physical_reads, 
	total_logical_writes, 
	min_logical_writes, 
	max_logical_writes, 
	average_logical_writes,
	total_clr_time, 
	min_clr_time, 
	max_clr_time, 
	average_clr_time,
	max_plan_generation_num,
	earliest_creation_time,
	query_rank,
	charted_value,
	master.dbo.fn_varbintohexstr(plan_handle) as plan_handle
	FROM   (SELECT s.*, 
				   Row_number() OVER(ORDER BY charted_value DESC) AS query_rank 
			FROM   (SELECT CASE @OrderBy_Criteria 
							 WHEN 'Logical Reads' THEN SUM(total_logical_reads) 
							 WHEN 'Physical Reads' THEN SUM(total_physical_reads) 
							 WHEN 'Logical Writes' THEN SUM(total_logical_writes) 
							 WHEN 'CPU' THEN SUM(total_worker_time) / 1000 
							 WHEN 'Duration' THEN SUM(total_elapsed_time) / 1000 
							 WHEN 'CLR Time' THEN SUM(total_clr_time) / 1000 
						   END AS charted_value, 
					   query_hash, 
					   MAX(sql_handle_1)				sql_handle, 
					   MAX(statement_start_offset_1)    statement_start_offset, 
					   MAX(statement_end_offset_1)      statement_end_offset, 
					   COUNT(*)							querycount, 
					   COUNT (DISTINCT query_plan_hash) queryplanhashcount, 
					   MAX(plan_handle_1)			plan_handle,
					   MIN(creation_time)				earliest_creation_time,
                 
					   SUM(execution_count)             execution_count, 
					   SUM(total_elapsed_time)          total_elapsed_time, 
					   min(min_elapsed_time)            min_elapsed_time, 
					   max(max_elapsed_time)            max_elapsed_time,
					   SUM(total_elapsed_time)/SUM(execution_count) average_elapsed_time, 
                       
					   SUM(total_worker_time)           total_CPU_time, 
					   min(min_worker_time)             min_CPU_time, 
					   max(max_worker_time)            max_CPU_time, 
					   SUM(total_worker_time)/SUM(execution_count) average_CPU_time, 

                       SUM(total_logical_reads)         total_logical_reads, 
                       min(min_logical_reads)           min_logical_reads, 
                       max(max_logical_reads)           max_logical_reads, 
                       SUM(total_logical_reads)/SUM(execution_count) average_logical_reads, 
                       
                       SUM(total_physical_reads)        total_physical_reads, 
                       min(min_physical_reads)         min_physical_reads, 
                       max(max_physical_reads)          max_physical_reads, 
                       SUM(total_physical_reads)/SUM(execution_count) average_physical_reads, 
                       
                       SUM(total_logical_writes)        total_logical_writes, 
                 
                       min(min_logical_writes)          min_logical_writes, 
                       max(max_logical_writes)          max_logical_writes, 
                       SUM(total_logical_writes)/SUM(execution_count) average_logical_writes, 
                       
                       SUM(total_clr_time)              total_clr_time, 
                       SUM(total_clr_time)/SUM(execution_count) average_clr_time, 
                       min(min_clr_time)                min_clr_time, 
                       max(max_clr_time)                max_clr_time, 
                       
                       MAX(plan_generation_num)         max_plan_generation_num
                FROM (
					-- Implement my own FIRST aggregate to get consistent values for sql_handle, start/end offsets of 
					-- an arbitrary first row for a given query_hash
                    SELECT 
						CASE when t.rownum = 1 THEN plan_handle ELSE NULL END as plan_handle_1,
						CASE WHEN t.rownum = 1 THEN sql_handle ELSE NULL END AS sql_handle_1, 
						CASE WHEN t.rownum = 1 THEN statement_start_offset ELSE NULL END AS statement_start_offset_1, 
						CASE WHEN t.rownum = 1 THEN statement_end_offset ELSE NULL END AS statement_end_offset_1, 
						* 
					FROM   (SELECT row_number() OVER (PARTITION BY query_hash ORDER BY sql_handle) AS rownum, * 
							FROM   sys.dm_exec_query_stats) AS t) AS t2 
					GROUP  BY query_hash
               ) AS s 
			WHERE  s.charted_value > 0
        ) AS qs
         
	CROSS APPLY msdb.MS_PerfDashboard.fn_QueryTextFromHandle(qs.sql_handle, 
		qs.statement_start_offset, qs.statement_end_offset) AS qt  
	where query_rank <= 20
	order by charted_value desc
end
