
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatNestedLoops(@node_data xml, @logical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Nested Loops(' + @logical_op

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:NestedLoops/sp:OuterReferences') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', OUTER REFERENCES:' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:NestedLoops/sp:OuterReferences/sp:ColumnReference'), 0x1)
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:NestedLoops/sp:Predicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', WHERE: (' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:NestedLoops/sp:Predicate/*')) + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:NestedLoops/sp:PassThru') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', PASSTHRU:(' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:NestedLoops/sp:PassThru/*')) + N')'
	end

	select @output = @output + N')'

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:NestedLoops[@Optimized = 1]') = 1)
	begin
		select @output = @output + N' OPTIMIZED'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:NestedLoops[@WithOrderedPrefetch = 1]') = 1)
	begin
		select @output = @output + N' WITH ORDERED PREFETCH'
	end
	else if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:NestedLoops[@WithUnorderedPrefetch = 1]') = 1)
	begin
		select @output = @output + N' WITH UNORDERED PREFETCH'
	end

	return @output;
end
