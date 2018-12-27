
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatSegment(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Segment'

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Segment/sp:GroupBy/sp:ColumnReference') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'(GROUP BY: ' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:Segment/sp:GroupBy/sp:ColumnReference'), 0x1) + N')'
	end

	return @output;
end
