
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatBitmap(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = N'Bitmap(Hash Keys:(' + MS_PerfDashboard.fn_ShowplanBuildColumnReferenceList(@node_data.query('./sp:Bitmap/sp:HashKeys/sp:ColumnReference'), 0x1) + N'))'

	return @output;
end
