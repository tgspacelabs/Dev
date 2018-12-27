create procedure MS_PerfDashboard.usp_Blocking
as
begin
	with blocking_hierarchy (head_wait_resource, session_id, blocking_session_id, tree_level, request_id, transaction_id, 
		status, sql_handle, plan_handle, statement_start_offset, statement_end_offset, wait_type, wait_time, wait_resource, 
		program_name, seconds_active_idle, open_transaction_count, transaction_isolation_level) 
	as 
	(
		select 
			(select min(wait_resource) from sys.dm_exec_requests where blocking_session_id = s.session_id) as head_wait_resource, 
			s.session_id, 
			convert(smallint, NULL), 
			convert(int, 0), 
			r.request_id, 
			coalesce(r.transaction_id, st.transaction_id), 
			isnull(r.status, 'idle'), 
			r.sql_handle, 
			r.plan_handle, 
			r.statement_start_offset, 
			r.statement_end_offset, 
			r.wait_type, 
			r.wait_time, 
			r.wait_resource, 
			s.program_name,
			case when r.request_id is null then datediff(ss, s.last_request_end_time, getdate()) else datediff(ss, r.start_time, getdate()) end,
			convert(int, p.open_tran),
			coalesce(r.transaction_isolation_level, s.transaction_isolation_level)
		from sys.dm_exec_sessions s
			join sys.sysprocesses p on s.session_id = p.spid
			left join sys.dm_exec_requests r on s.session_id = r.session_id
			left join sys.dm_tran_session_transactions st on s.session_id = st.session_id
		where s.session_id in (select blocking_session_id from sys.dm_exec_requests) 
			and isnull(r.blocking_session_id, 0) = 0

		union all

		select b.head_wait_resource, 
			r.session_id, 
			r.blocking_session_id, 
			tree_level + 1, 
			r.request_id, 
			r.transaction_id, 
			r.status, 
			r.sql_handle, 
			r.plan_handle, 
			r.statement_start_offset, 
			r.statement_end_offset, 
			r.wait_type, 
			r.wait_time, 
			r.wait_resource, 
			NULL,
			NULL,
			r.open_transaction_count,
			r.transaction_isolation_level
		from sys.dm_exec_requests r
			join blocking_hierarchy b on r.blocking_session_id = b.session_id
	)
	select b.head_wait_resource,
		b.session_id, 
		b.request_id, 
		b.blocking_session_id, 
		b.program_name, 
		b.tree_level, 
		case when LEN(qt.query_text) < 2048 then qt.query_text else LEFT(qt.query_text, 2048) + N'...' end as query_text,
		master.dbo.fn_varbintohexstr(b.sql_handle) as sql_handle, 
		master.dbo.fn_varbintohexstr(b.plan_handle) as plan_handle, 
		b.statement_start_offset, 
		b.statement_end_offset, 
		b.status as session_or_request_status, 
		b.wait_type, 
		b.wait_time, 
		b.wait_resource, 
		b.transaction_id, 
		b.transaction_isolation_level,
		b.open_transaction_count,
		b.seconds_active_idle,
		t.name as transaction_name, 
		t.transaction_begin_time, 
		t.transaction_type, 
		t.transaction_state, 
		t.dtc_state, 
		t.dtc_isolation_level,
		st.enlist_count, 
		st.is_user_transaction, 
		st.is_local, 
		st.is_enlisted, 
		st.is_bound
	from blocking_hierarchy b
		left join sys.dm_tran_session_transactions st on st.transaction_id = b.transaction_id and st.session_id = b.session_id
		left join sys.dm_tran_active_transactions t on t.transaction_id = b.transaction_id
		outer apply msdb.MS_PerfDashboard.fn_QueryTextFromHandle(b.sql_handle, b.statement_start_offset, b.statement_end_offset) as qt
end
