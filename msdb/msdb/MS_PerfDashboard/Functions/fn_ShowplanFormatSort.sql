
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatSort(@node_data xml, @logical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Sort('

	if @logical_op = N'Sort'
	begin
		if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Sort[@Distinct = 1]') = 1)
		begin
			select @output = @output + N'DISTINCT '
		end

		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'ORDER BY: (' + MS_PerfDashboard.fn_ShowplanBuildOrderBy(@node_data.query('./sp:Sort/sp:OrderBy/sp:OrderByColumn')) + N')'
	end
	else if @logical_op = N'TopN Sort'
	begin
		select @output = @output + N'TOP ' + @node_data.value('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; (./sp:TopSort/@Rows)[1]', 'nvarchar(50)') + N', '

		if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:TopSort[@Distinct = 1]') = 1)
		begin
			select @output = @output + N'DISTINCT '
		end

		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'ORDER BY: (' + MS_PerfDashboard.fn_ShowplanBuildOrderBy(@node_data.query('./sp:TopSort/sp:OrderBy/sp:OrderByColumn')) + N')'
	end
	else if @logical_op = N'Distinct Sort'
	begin
		select @output = @output + N'DISTINCT '

		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'ORDER BY: (' + MS_PerfDashboard.fn_ShowplanBuildOrderBy(@node_data.query('./sp:Sort/sp:OrderBy/sp:OrderByColumn')) + N')'
	end

	select @output = @output + N')'

	return @output;
end
