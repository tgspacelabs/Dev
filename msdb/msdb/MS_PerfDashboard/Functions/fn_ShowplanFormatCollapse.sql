
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatCollapse(@node_data xml)
RETURNS nvarchar(max)
as
begin
	return N'Collapse'
end
