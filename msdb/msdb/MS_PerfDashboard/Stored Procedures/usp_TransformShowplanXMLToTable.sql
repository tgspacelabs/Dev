
CREATE PROCEDURE MS_PerfDashboard.usp_TransformShowplanXMLToTable @plan_handle nvarchar(256), @stmt_start_offset int, @stmt_end_offset int, @fDebug bit = 0x0
AS
BEGIN
	SET NOCOUNT ON

	declare @plan nvarchar(max)
	declare @dbid int, @objid int
	declare @xml_plan xml
	declare @error int

	declare @output TABLE (
		node_id int, 
		parent_node_id int, 
		relevant_xml_text nvarchar(max), 
		stmt_text nvarchar(max), 
		logical_op nvarchar(128), 
		physical_op nvarchar(128), 
		output_list nvarchar(max), 
		avg_row_size float, 
		est_cpu float, 
		est_io float, 
		est_rows float, 
		est_rewinds float, 
		est_rebinds float, 
		est_subtree_cost float,
		warnings nvarchar(max))

	BEGIN TRY
		-- handle may be invalid now, or XML may be too deep to convert
		select @dbid = p.dbid, @objid = p.objectid, @plan = p.query_plan from sys.dm_exec_text_query_plan(msdb.MS_PerfDashboard.fn_hexstrtovarbin(@plan_handle), @stmt_start_offset, @stmt_end_offset) as p
		select @xml_plan = convert(xml, @plan)

		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		insert into @output 
		select nd.node_id,
			x.parent_node_id,
			case when @fDebug = 0x1 then 
							case 
								when x.parent_node_id is null then @plan 
								else convert(nvarchar(max), x.plan_node) 
							end
					else NULL
					end as relevant_xml_text,
			nd.stmt_text, 
			nd.logical_op, 
			nd.physical_op, 
			nd.output_list, 
			nd.avg_row_size, 
			nd.est_cpu, 
			nd.est_io, 
			nd.est_rows, 
			nd.est_rewinds, 
			nd.est_rebinds, 
			nd.est_subtree_cost,
			nd.warnings
		from (select 
				splan.row.query('.') as plan_node,
				splan.row.value('../../@NodeId', 'int') as parent_node_id
			from (select @xml_plan as query_plan) as p
				cross apply p.query_plan.nodes('//sp:RelOp') as splan (row)) as x
				outer apply MS_PerfDashboard.fn_ShowplanRowDetails(plan_node) as nd
		order by isnull(parent_node_id, -1) asc

		-- Statements such as WAITFOR, etc may not have a RelOp so just show the statement type if available
		if @@rowcount = 0
		begin
			;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
			insert into @output (stmt_text) select isnull(@xml_plan.value('(//@StatementType)[1]', 'nvarchar(max)'), N'Unknown Statement')
		end
	END TRY
	BEGIN CATCH
		select @error = ERROR_NUMBER()
-- 		select 
-- 			cast(NULL as int) as node_id, 
-- 			cast(NULL as int) as parent_node_id,
-- 			cast(NULL as nvarchar(max)) as relevant_xml_text,
-- 			cast(NULL as nvarchar(max)) as stmt_text,
-- 			cast(NULL as nvarchar(128)) as logical_op,
-- 			cast(NULL as nvarchar(128)) as physical_op,
-- 			cast(NULL as nvarchar(max)) as output_list,
-- 			cast(NULL as float) as avg_row_size,
-- 			cast(NULL as float) as est_cpu,
-- 			cast(NULL as float) as est_io,
-- 			cast(NULL as float) as est_rows,
-- 			cast(NULL as float) as est_rewinds,
-- 			cast(NULL as float) as est_rebinds,
-- 			cast(NULL as float) as est_subtree_cost,
-- 			cast(NULL as nvarchar(max)) as warnings
-- 		where 0 = 1
	END CATCH

	-- This may be an empty set if there was an exception caught above
	SELECT
		node_id,
		parent_node_id, 
		relevant_xml_text, 
		stmt_text, 
		logical_op, 
		physical_op, 
		output_list, 
		avg_row_size, 
		est_cpu, 
		est_io, 
		est_rows, 
		est_rewinds, 
		est_rebinds, 
		est_subtree_cost,
		warnings
	FROM @output
END
