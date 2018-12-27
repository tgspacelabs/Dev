
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatFilter(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	declare @fStartup tinyint

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @fStartup = case when (@node_data.exist('./sp:Filter[@StartupExpression = 1]') = 1) then 1 else 0 end

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = N'Filter(WHERE: (' + 
		case when @fStartup = 1 then N'STARTUP EXPRESSION(' else N'' end + 
		MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:Filter/sp:Predicate/*')) +
		case when @fStartup = 1 then N')' else N'' end + 
		N'))'

	return @output;
end
