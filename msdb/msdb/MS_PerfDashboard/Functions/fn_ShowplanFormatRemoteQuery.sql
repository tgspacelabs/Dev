
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatRemoteQuery(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Remote Query('

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RemoteQuery/@RemoteSource') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'SOURCE: (' + @node_data.value('(./sp:RemoteQuery/@RemoteSource)[1]', 'nvarchar(256)') + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RemoteQuery/@RemoteObject') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'OBJECT: (' + @node_data.value('(./sp:RemoteQuery/@RemoteObject)[1]', 'nvarchar(256)') + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RemoteQuery/@RemoteQuery') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N', QUERY: (' + @node_data.value('(./sp:RemoteQuery/@RemoteQuery)[1]', 'nvarchar(max)') + N')'
	end

	select @output = @output + N')'

	return @output;
end
