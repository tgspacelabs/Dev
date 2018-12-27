create procedure MS_PerfDashboard.usp_DatabaseOverview
as
begin
	select d.name, d.database_id, d.compatibility_level, d.recovery_model_desc,
		s.[Data File(s) Size (KB)] / 1024.0 as [Data File(s) Size (MB)], 
		s.[Log File(s) Size (KB)] / 1024.0 as [Log File(s) Size (MB)],
		s.[Percent Log Used],
		d.is_auto_create_stats_on,
		d.is_auto_update_stats_on,
		d.is_auto_update_stats_async_on,
		d.is_parameterization_forced,
		d.page_verify_option_desc,
		d.log_reuse_wait_desc
	from sys.databases d
		left join (select * from (select instance_name as database_name, counter_name, cntr_value 
				from sys.dm_os_performance_counters 
				where object_name like '%:Databases%' and counter_name in ('Data File(s) Size (KB)', 'Log File(s) Size (KB)', 'Percent Log Used')
					and instance_name != '_Total') p 
					pivot (min(cntr_value) for counter_name in ([Data File(s) Size (KB)], [Log File(s) Size (KB)], [Percent Log Used])) as q) as s 
		on d.name = s.database_name
end
