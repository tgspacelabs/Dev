create procedure MS_PerfDashboard.usp_ShowplanAttributes @plan_handle nvarchar(256), @stmt_start_offset int, @stmt_end_offset int
as
begin
	declare @plan_text nvarchar(max)
	declare @plan_xml xml
	declare @missing_index_count int
	declare @plan_guide_name nvarchar(128)
	declare @warnings_exist bit
	declare @plan_dbid smallint
	declare @plan_dbname nvarchar(128)

	begin try
		select @plan_dbid = convert(smallint, pa.value) from sys.dm_exec_plan_attributes(msdb.MS_PerfDashboard.fn_hexstrtovarbin(@plan_handle)) as pa where pa.attribute = 'dbid'
		select @plan_dbname = quotename(db_name(@plan_dbid))

		--plan_handle may now be invalid, or xml could be > 128 levels deep such that conversion fails
		select @plan_text = p.query_plan from sys.dm_exec_text_query_plan(msdb.MS_PerfDashboard.fn_hexstrtovarbin(@plan_handle), @stmt_start_offset, @stmt_end_offset) as p
		select @plan_xml = convert(xml, @plan_text)

		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @missing_index_count = @plan_xml.value('count(//sp:MissingIndexes/sp:MissingIndexGroup)', 'int'),
			@plan_guide_name = @plan_xml.value('(//sp:StmtSimple/@PlanGuideName)[1]', 'nvarchar(128)'),
			@warnings_exist = @plan_xml.exist('//sp:Warnings')
			
		-- TODO: warning for optimizer timeout/memory abort: @StatementOptmEarlyAbortReason
	end try
	begin catch
		select @plan_xml = NULL		--something required in catch block, and this does no harm
	end catch

	select 
		@plan_text as query_plan, 
		@plan_dbid as plan_database_id, 
		@plan_dbname as plan_database_name, 
		@missing_index_count as missing_index_count, 
		@plan_guide_name as plan_guide_name, 
		@warnings_exist as warnings_exist
end
