
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatConstantScan(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Constant Scan'

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:ConstantScan/sp:Values') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'(VALUES: (' + MS_PerfDashboard.fn_ShowplanBuildScalarExpressionList(@node_data.query('./sp:ConstantScan/sp:Values/sp:Row/*')) + N'))'
	end

	return @output
end
