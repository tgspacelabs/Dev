
-- Passed the Rowset element of XML showplan and extracts the Object details
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatDeletedInsertedScan(@node_data xml, @physical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = @physical_op + N'(' + MS_PerfDashboard.fn_ShowplanBuildRowset(@node_data) + N')'

	return @output;
end
