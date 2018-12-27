
create function MS_PerfDashboard.fn_ShowplanBuildDefinedValuesList (@node_data xml)
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = convert(nvarchar(max), @node_data.query('for $val in /sp:DefinedValue
				return concat(($val/sp:ColumnReference/@Column)[1], "=", ($val/sp:ScalarOperator/@ScalarString)[1], ",")'))

	declare @len int
	select @len = len(@output)
	if (@len > 0)
	begin
		select @output = left(@output, @len - 1)
	end

	return @output
end
