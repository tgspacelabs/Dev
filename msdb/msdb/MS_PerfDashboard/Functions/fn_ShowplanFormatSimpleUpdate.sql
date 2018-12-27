
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatSimpleUpdate(@node_data xml, @physical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = @physical_op + N'(' + MS_PerfDashboard.fn_ShowplanBuildObject(@node_data.query('./sp:Object'))

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:SetPredicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', SET: ' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:SetPredicate/*'))
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:SeekPredicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', WHERE: (' + MS_PerfDashboard.fn_ShowplanBuildSeekPredicate(@node_data.query('./sp:SeekPredicate/*')) + N')'
	end

	select @output = @output + N')'

	return @output;
end
