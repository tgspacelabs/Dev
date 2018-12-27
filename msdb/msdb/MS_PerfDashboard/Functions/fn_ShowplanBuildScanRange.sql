
create function MS_PerfDashboard.fn_ShowplanBuildScanRange (@node_data xml, @scan_type nvarchar(30))
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)
	set @output = N''

	declare @count int, @ctr int

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RangeColumns') = 1)
	begin	
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @ctr = 1, @count = @node_data.value('count(./sp:RangeColumns/sp:ColumnReference)', 'int')

		while @ctr <= @count
		begin
			;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
			select @output = @output + 
					case when @ctr > 1 then N' AND ' else '' end + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:RangeColumns/sp:ColumnReference[position() = sql:variable("@ctr")]'), 0x1)
					+ N' ' + 
				case UPPER(@scan_type) 
					when 'BINARY IS' then N'IS'
					when 'EQ' then N'='
					when 'GE' then N'>='
					when 'GT' then N'>'
					when 'IS' then N'IS'
					when 'IS NOT' then N'IS NOT'
					when 'IS NOT NULL' then N'IS NOT NULL'
					when 'IS NULL' then N'IS NULL'
					when 'LE' then N'<='
					when 'LT' then N'<'
					when 'NE' then N'<>'
				end
				 + N' '
				+ MS_PerfDashboard.fn_ShowplanBuildScalarExpressionList(@node_data.query('./sp:RangeExpressions/sp:ScalarOperator[position() = sql:variable("@ctr")]'))

			select @ctr = @ctr + 1
		end
	end
	

	--if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RangeExpressions') = 1)
	--begin
	--	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	--	select @output = @output + N'(RANGE: (' + MS_PerfDashboard.fn_ShowplanBuildScalarExpressionList(@node_data.query('./sp:RangeExpressions/*')) + N'))'
	--end

	return @output
end
