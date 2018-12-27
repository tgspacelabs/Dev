
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatRIDLookup(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max) = '';

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:IndexScan') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + MS_PerfDashboard.fn_ShowplanFormatIndexScan(@node_data.query('./sp:IndexScan'), 'RID Lookup')
		select @output = @output + N')'
	end

	return @output;
end
