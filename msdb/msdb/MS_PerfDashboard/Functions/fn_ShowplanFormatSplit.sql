
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatSplit(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Split'

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Split/sp:ActionColumn') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'(' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:Split/sp:ActionColumn/sp:ColumnReference'), 0x1) + N')'
	end

	return @output;
end
