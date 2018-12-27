
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatTop(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Top'

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Top/sp:TopExpression') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'(TOP EXPRESSION: ' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:Top/sp:TopExpression/*')) + N')'
	end

	return @output;
end
