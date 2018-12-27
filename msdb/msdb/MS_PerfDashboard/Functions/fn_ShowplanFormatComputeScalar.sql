
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatComputeScalar(@node_data xml, @physical_op nvarchar(128))
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = @physical_op + N'(DEFINE: (' + MS_PerfDashboard.fn_ShowplanBuildDefinedValuesList(@node_data.query('./sp:DefinedValues/*')) + N'))';

	return @output;
end
