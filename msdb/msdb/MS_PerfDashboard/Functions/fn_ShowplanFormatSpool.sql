
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatSpool(@node_data xml, @physical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = @physical_op

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Spool/sp:SeekPredicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'(' + MS_PerfDashboard.fn_ShowplanBuildSeekPredicate(@node_data.query('./sp:Spool/sp:SeekPredicate/*')) + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Spool[@Stack = 1]') = 1)
	begin
		select @output = @output + N' WITH STACK'
	end

	return @output;
end
