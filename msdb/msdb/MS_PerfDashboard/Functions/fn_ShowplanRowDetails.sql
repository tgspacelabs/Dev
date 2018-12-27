
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanRowDetails(@relop_node xml)
returns @node TABLE (node_id int, stmt_text nvarchar(max), logical_op nvarchar(128), physical_op nvarchar(128), output_list nvarchar(max), avg_row_size float, est_cpu float, est_io float, est_rows float, est_rewinds float, est_rebinds float, est_subtree_cost float, warnings nvarchar(max))
AS
begin
	declare @node_id int
	declare @output_list nvarchar(max)
	declare @stmt_text nvarchar(max)
	declare @logical_op nvarchar(128), @physical_op nvarchar(128)
	declare @avg_row_size float, @est_cpu float, @est_io float, @est_rows float, @est_rewinds float, @est_rebinds float, @est_subtree_cost float
	declare @relop_children xml

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @logical_op = @relop_node.value('(./sp:RelOp/@LogicalOp)[1]', 'nvarchar(128)'),
		@physical_op = @relop_node.value('(./sp:RelOp/@PhysicalOp)[1]', 'nvarchar(128)'),
		@relop_children = @relop_node.query('./sp:RelOp/*')

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @stmt_text =
		case 
			when @physical_op = N'Assert' then MS_PerfDashboard.fn_ShowplanFormatAssert(@relop_children)
			when @physical_op = N'Bitmap' then MS_PerfDashboard.fn_ShowplanFormatBitmap(@relop_children)
			when @physical_op in (N'Clustered Index Delete', N'Clustered Index Insert', N'Clustered Index Update', N'Clustered Index Merge', 
						N'Index Delete', N'Index Insert', N'Index Update', 
						N'Table Delete', N'Table Insert', N'Table Update') then MS_PerfDashboard.fn_ShowplanFormatGenericUpdate(@relop_children, @physical_op)
			when @physical_op in (N'Clustered Index Scan', N'Clustered Index Seek', 
						N'Index Scan', N'Index Seek') then MS_PerfDashboard.fn_ShowplanFormatIndexScan(@relop_children, @physical_op)
--			when @physical_op = N'Clustered Update' then 
			when @physical_op = N'Collapse' then N'Collapse'
			when @physical_op = N'Compute Scalar' then MS_PerfDashboard.fn_ShowplanFormatComputeScalar(@relop_children.query('./sp:ComputeScalar/*'), @physical_op)
			when @physical_op = N'Concatenation' then MS_PerfDashboard.fn_ShowplanFormatConcat(@relop_children)
			when @physical_op = N'Constant Scan' then MS_PerfDashboard.fn_ShowplanFormatConstantScan(@relop_children)
			when @physical_op = N'Deleted Scan' then MS_PerfDashboard.fn_ShowplanFormatDeletedInsertedScan(@relop_children.query('./sp:DeletedScan/*'), @physical_op)
			when @physical_op = N'Filter' then MS_PerfDashboard.fn_ShowplanFormatFilter(@relop_children)
--			when @physical_op = N'Generic' then 
			when @physical_op = N'Hash Match' then MS_PerfDashboard.fn_ShowplanFormatHashMatch(@relop_children, @logical_op)
			when @physical_op = N'Index Spool' then MS_PerfDashboard.fn_ShowplanFormatSpool(@relop_children, @physical_op)
			when @physical_op = N'Inserted Scan' then MS_PerfDashboard.fn_ShowplanFormatDeletedInsertedScan(@relop_children.query('./sp:InsertedScan/*'), @physical_op)
			when @physical_op = N'Log Row Scan' then N'Log Row Scan'
			when @physical_op = N'Merge Interval' then N'Merge Interval'
			when @physical_op = N'Merge Join' then MS_PerfDashboard.fn_ShowplanFormatMerge(@relop_children, @logical_op)
			when @physical_op = N'Nested Loops' then MS_PerfDashboard.fn_ShowplanFormatNestedLoops(@relop_children, @logical_op)
			when @physical_op = N'Online Index Insert' then N'Online Index Insert'
			when @physical_op = N'Parallelism' then MS_PerfDashboard.fn_ShowplanFormatParallelism(@relop_children, @logical_op)
			when @physical_op = N'Parameter Table Scan' then N'Parameter Table Scan'
			when @physical_op = N'Print' then N'Print'
			when @physical_op in (N'Remote Delete', N'Remote Insert', N'Remote Update') then MS_PerfDashboard.fn_ShowplanFormatRemoteModify(@relop_children, @logical_op)
			when @physical_op = N'Remote Scan' then MS_PerfDashboard.fn_ShowplanFormatRemoteScan(@relop_children)
			when @physical_op = N'Remote Query' then MS_PerfDashboard.fn_ShowplanFormatRemoteQuery(@relop_children)
			when @physical_op = N'RID Lookup' then MS_PerfDashboard.fn_ShowplanFormatRIDLookup(@relop_children)
			when @physical_op = N'Row Count Spool' then MS_PerfDashboard.fn_ShowplanFormatSpool(@relop_children, @physical_op)
			when @physical_op = N'Segment' then MS_PerfDashboard.fn_ShowplanFormatSegment(@relop_children)
			when @physical_op = N'Sequence' then N'Sequence'
			when @physical_op = N'Sequence Project' then MS_PerfDashboard.fn_ShowplanFormatComputeScalar(@relop_children.query('./sp:SequenceProject/*'), @physical_op)
			when @physical_op = N'Sort' then MS_PerfDashboard.fn_ShowplanFormatSort(@relop_children, @logical_op)
			when @physical_op = N'Split' then MS_PerfDashboard.fn_ShowplanFormatSplit(@relop_children)
			when @physical_op = N'Stream Aggregate' then MS_PerfDashboard.fn_ShowplanFormatStreamAggregate(@relop_children)
			when @physical_op = N'Switch' then N'Switch'
			when @physical_op = N'Table-valued function' then MS_PerfDashboard.fn_ShowplanFormatTVF(@relop_children)
			when @physical_op = N'Table Scan' then MS_PerfDashboard.fn_ShowplanFormatTableScan(@relop_children)
			when @physical_op = N'Table Spool' then MS_PerfDashboard.fn_ShowplanFormatSpool(@relop_children, @physical_op)
			when @physical_op = N'Table Merge' then N'Table Merge'
			when @physical_op = N'Top' then MS_PerfDashboard.fn_ShowplanFormatTop(@relop_children)
			when @physical_op = N'UDX' then MS_PerfDashboard.fn_ShowplanFormatUDX(@relop_children)
			else @physical_op + N'(' + @logical_op + N')'
		end	

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	insert @node (
		node_id,
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
		warnings)
	values (
		@relop_node.value('(./sp:RelOp/@NodeId)[1]', 'int'),
		@stmt_text, 
		@logical_op, 
		@physical_op, 
		MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@relop_node.query('./sp:RelOp/sp:OutputList/sp:ColumnReference'), 0x1),
		@relop_node.value('(./sp:RelOp/@AvgRowSize)[1]', 'float'),
		@relop_node.value('(./sp:RelOp/@EstimateCPU)[1]', 'float'),
		@relop_node.value('(./sp:RelOp/@EstimateIO)[1]', 'float'),
		@relop_node.value('(./sp:RelOp/@EstimateRows)[1]', 'float'), 
		@relop_node.value('(./sp:RelOp/@EstimateRewinds)[1]', 'float'), 
		@relop_node.value('(./sp:RelOp/@EstimateRebinds)[1]', 'float'), 
		@relop_node.value('(./sp:RelOp/@EstimatedTotalSubtreeCost)[1]', 'float'),
		MS_PerfDashboard.fn_ShowplanBuildWarnings(@relop_node)
		);

	return;
end
