create procedure MS_PerfDashboard.usp_QueryAttributes @sql_handle varchar(8000), @stmt_start_offset int, @stmt_end_offset int
as
begin
	select 
		qt.database_id,
		quotename(db_name(qt.database_id)) as database_name,
		qt.object_id,
		quotename(object_schema_name(qt.object_id, qt.database_id)) + N'.' + quotename(object_name(qt.object_id, qt.database_id)) as qualified_object_name,
		qt.encrypted,
		qt.query_text
	from msdb.MS_PerfDashboard.fn_QueryTextFromHandle(msdb.MS_PerfDashboard.fn_hexstrtovarbin(@sql_handle), @stmt_start_offset, @stmt_end_offset) as qt
end
