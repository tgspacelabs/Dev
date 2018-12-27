create procedure MS_PerfDashboard.usp_PlanParameters @plan_handle nvarchar(256), @stmt_start_offset int, @stmt_end_offset int
as
begin
	declare @plan_xml xml
	begin try
		-- convert may fail due to exceeding 128 depth limit
		select @plan_xml = convert(xml, query_plan) from sys.dm_exec_text_query_plan(msdb.MS_PerfDashboard.fn_hexstrtovarbin(@plan_handle), @stmt_start_offset, @stmt_end_offset)
	end try
	begin catch
		select @plan_xml = NULL
	end catch

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	SELECT 
		parameter_list.param_node.value('(./@Column)[1]', 'nvarchar(128)') as param_name,
		parameter_list.param_node.value('(./@ParameterCompiledValue)[1]', 'nvarchar(max)') as param_compiled_value
	from (select @plan_xml as xml_showplan) as t
		outer apply t.xml_showplan.nodes('//sp:ParameterList/sp:ColumnReference') as parameter_list (param_node)
end
