
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatGenericUpdate(@node_data xml, @physical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:SimpleUpdate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = MS_PerfDashboard.fn_ShowplanFormatSimpleUpdate(@node_data.query('./sp:SimpleUpdate/*'), @physical_op)
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Update') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = MS_PerfDashboard.fn_ShowplanFormatUpdate(@node_data.query('./sp:Update/*'), @physical_op)
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:ScalarInsert') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @physical_op + '(' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:ScalarInsert/sp:SetPredicate/*')) + ')'
	end

	return @output;
end
