
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatUDX(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = N'UDX(' + @node_data.value('(./sp:Extension/@UDXName)[1]', 'nvarchar(128)') + N')'

	return @output;
end
