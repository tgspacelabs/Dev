
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatRemoteModify(@node_data xml, @logical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = @logical_op + N'('

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RemoteModify/@RemoteSource') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'SOURCE: (' + @node_data.value('(./sp:RemoteModify/@RemoteSource)[1]', 'nvarchar(256)') + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RemoteModify/@RemoteObject') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'OBJECT: (' + @node_data.value('(./sp:RemoteModify/@RemoteObject)[1]', 'nvarchar(256)') + N')'
	end


	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RemoteModify/sp:SetPredicate') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'WHERE: (' + MS_PerfDashboard.fn_ShowplanBuildScalarExpression(@node_data.query('./sp:RemoteModify/sp:SetPredicate/*')) + N')'
	end

	select @output = @output + N')'

	return @output;
end
