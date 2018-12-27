create procedure MS_PerfDashboard.usp_XEventSessions
as
begin
	select convert(bigint, address) xeaddress,
		case when row_num = 1 then session_name else NULL end as session_name,
		case when row_num = 1 then create_time else NULL end as create_time,
		case when row_num = 1 then target_name else NULL end as target_name,
		case when row_num = 1 then execution_count else NULL end as execution_count,
		case when row_num = 1 then execution_duration_ms else NULL end as execution_duration_ms,
		case when row_num = 1 then dropped_event_count else NULL end as dropped_event_count,
		case when row_num = 1 then buffer_policy_desc else NULL end as buffer_policy_desc,
		case when row_num = 1 then total_buffer_size else NULL end as total_buffer_size,
		event_name,
		action_name
		

	from (
		select s.address, ROW_NUMBER() over (partition by s.address order by sea.event_name, sea.action_name ) as row_num,
		s.name session_name ,s.create_time, st.target_name, st.execution_count, st.execution_duration_ms, 
		sea.action_name, sea.event_name, s.dropped_event_count, s.total_buffer_size, s.buffer_policy_desc
		from sys.dm_xe_sessions s 
		inner join sys.dm_xe_session_targets st
		  on s.address = st.event_session_address
		inner join sys.dm_xe_session_event_actions sea
		  on s.address = sea.event_session_address ) as inner_t
end
