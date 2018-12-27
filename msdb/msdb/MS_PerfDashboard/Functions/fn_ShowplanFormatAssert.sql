
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatAssert(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = N'Assert(' + @node_data.value('(./sp:Assert/sp:Predicate/sp:ScalarOperator/@ScalarString)[1]', 'nvarchar(max)') + N'))'

	return @output;
end
