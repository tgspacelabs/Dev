
create function MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList (@node_data xml, @include_alias_or_table bit)
returns nvarchar(max)

as
begin
	declare @output nvarchar(max)

	declare @count int, @ctr int

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = N'', @ctr = 1, @count = @node_data.value('count(./sp:ColumnReference)', 'int')

	-- iterate over each element in the list
	while @ctr <= @count
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + case when @ctr > 1 then N', ' else N'' end + MS_PerfDashboard.fn_ShowplanBuildColumnReference(@node_data.query('./sp:ColumnReference[position() = sql:variable("@ctr")]'), @include_alias_or_table)

		select @ctr = @ctr + 1
	end

	return @output
end
