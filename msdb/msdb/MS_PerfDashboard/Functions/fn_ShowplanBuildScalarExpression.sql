
create function MS_PerfDashboard.fn_ShowplanBuildScalarExpression (@node_data xml)
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)

	select @output = N''

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = @node_data.value('(./sp:ScalarOperator/@ScalarString)[1]', 'nvarchar(max)')

	return @output
end
