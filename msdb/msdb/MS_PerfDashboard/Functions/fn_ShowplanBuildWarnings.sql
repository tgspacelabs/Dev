
create function MS_PerfDashboard.fn_ShowplanBuildWarnings(@relop_node xml)
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)

	if (@relop_node.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RelOp/sp:Warnings') = 1)
	begin
		if (@relop_node.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RelOp/sp:Warnings[@NoJoinPredicate = 1]') = 1)
		begin
			select @output = N'NO JOIN PREDICATE'
		end
		
		if (@relop_node.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RelOp/sp:Warnings/sp:ColumnsWithNoStatistics') = 1)
		begin
			;with xmlnamespaces ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' as sp)
			select @output = case when @output is null then N'' else @output + N', ' end + N'NO STATS: ' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@relop_node.query('./sp:RelOp/sp:Warnings/sp:ColumnsWithNoStatistics/*'), 0x1)
		end
	end

	return @output
end
