
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatStreamAggregate(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	declare @need_comma bit

	select @output = N'Stream Aggregate('

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:StreamAggregate/sp:GroupBy') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'GROUP BY: (' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:StreamAggregate/sp:GroupBy/sp:ColumnReference'), 0x1) + N')'
		select @need_comma = 0x1
	end

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = @output + 
			case when @need_comma = 0x1 then N', ' else N'' end 
		+ N'DEFINE: (' + MS_PerfDashboard.fn_ShowplanBuildDefinedValuesList(@node_data.query('./sp:StreamAggregate/sp:DefinedValues/sp:DefinedValue')) + N')'

	select @output = @output + N')'

	return @output;
end
