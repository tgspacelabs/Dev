
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatTVF(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Table-valued Function('

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:TableValuedFunction/sp:Object') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'OBJECT: (' + MS_PerfDashboard.fn_ShowplanBuildObject(@node_data.query('./sp:TableValuedFunction/sp:Object')) + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:TableValuedFunction/sp:Predicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', WHERE: ( ' + MS_PerfDashboard.fn_ShowplanBuildPredicate(@node_data.query('./sp:TableValuedFunction/sp:Predicate')) + N')'
	end

	select @output = @output + N')'

	return @output;
end
