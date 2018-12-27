
create function MS_PerfDashboard.fn_ShowplanBuildRowset (@node_data xml)
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = MS_PerfDashboard.fn_ShowplanBuildObject(@node_data.query('./sp:Object'))

	return @output
end
