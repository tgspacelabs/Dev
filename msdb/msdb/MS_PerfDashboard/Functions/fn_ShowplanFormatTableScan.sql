
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatTableScan(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Table Scan('

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = @output + MS_PerfDashboard.fn_ShowplanBuildObject(@node_data.query('./sp:TableScan/sp:Object'))

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:TableScan/sp:Predicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', WHERE: (' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:TableScan/sp:Predicate/*')) + N')'
	end
	
	select @output = @output + N')'

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:TableScan[@Ordered = 1]') = 1)
	begin
		select @output = @output + N' ORDERED'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:TableScan[@ForcedIndex = 1]') = 1)
	begin
		select @output = @output + N' FORCEDINDEX'
	end


	return @output;
end
