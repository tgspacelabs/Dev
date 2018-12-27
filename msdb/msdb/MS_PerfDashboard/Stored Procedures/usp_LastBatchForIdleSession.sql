create procedure MS_PerfDashboard.usp_LastBatchForIdleSession @session_id int
as
begin
	if not exists (select * from sys.dm_exec_requests where session_id = @session_id)
	begin
		select t.dbid, db_name(t.dbid) as database_name, t.objectid, object_name(t.dbid, t.objectid) as object_name, 
		case when t.encrypted = 0 then t.text else N'encrypted' end as last_query 
		from sys.dm_exec_connections c
			cross apply sys.dm_exec_sql_text(c.most_recent_sql_handle) as t
		where c.most_recent_session_id = @session_id
	end
	else
	begin
		select cast(NULL as smallint), cast (NULL as sysname), cast(NULL as int), cast(NULL as sysname), cast(NULL as nvarchar(max)) where 0 = 1
	end
end
