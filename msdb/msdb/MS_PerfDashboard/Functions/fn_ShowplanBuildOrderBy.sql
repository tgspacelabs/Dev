
create function MS_PerfDashboard.fn_ShowplanBuildOrderBy (@node_data xml)
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = convert(nvarchar(max), @node_data.query('for $col in /sp:OrderByColumn
					return concat(if (($col/sp:ColumnReference/@Alias)[1] > "") then concat(($col/sp:ColumnReference/@Alias)[1], ".") else if (($col/sp:ColumnReference/@Table)[1] > "") then concat(($col/sp:ColumnReference/@Table)[1], ".") else "", string(($col/sp:ColumnReference/@Column)[1]), if ($col/@Ascending = 1) then " ASC" else " DESC", ",")'))
	declare @len int
	select @len = len(@output)
	if (@len > 0)
	begin
		select @output = left(@output, @len - 1)
	end

	return @output
end
