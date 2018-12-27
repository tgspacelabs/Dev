create procedure MS_PerfDashboard.usp_QueryText @sql_handle varchar(8000), @stmt_start_offset int, @stmt_end_offset int
as
begin
	select * from msdb.MS_PerfDashboard.fn_QueryTextFromHandle(msdb.MS_PerfDashboard.fn_hexstrtovarbin(@sql_handle), @stmt_start_offset, @stmt_end_offset);
end
