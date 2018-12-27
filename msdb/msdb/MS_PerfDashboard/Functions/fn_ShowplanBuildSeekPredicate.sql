
create function MS_PerfDashboard.fn_ShowplanBuildSeekPredicate (@node_data xml)
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)
	set @output = N''

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:IsNotNull') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + MS_PerfDashboard.fn_ShowplanBuildColumnReference(@node_data.query('./sp:IsNotNull/sp:ColumnReference'), 0x0) + N' IS NOT NULL'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Prefix') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + MS_PerfDashboard.fn_ShowplanBuildScanRange(@node_data.query('./sp:Prefix/*'), @node_data.value('(./sp:Prefix/@ScanType)[1]', 'nvarchar(100)'))
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:StartRange') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + case when datalength(@output) > 0 then N' AND ' else '' end + MS_PerfDashboard.fn_ShowplanBuildScanRange(@node_data.query('./sp:StartRange/*'), @node_data.value('(./sp:StartRange/@ScanType)[1]', 'nvarchar(100)'))
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:EndRange') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + case when datalength(@output) > 0 then N' AND ' else '' end + MS_PerfDashboard.fn_ShowplanBuildScanRange(@node_data.query('./sp:EndRange/*'), @node_data.value('(./sp:EndRange/@ScanType)[1]', 'nvarchar(100)'))
	end

	return @output
end
