
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatRemoteScan(@node_data xml)
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)
	select @output = N'Remote Scan('

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RemoteScan/@RemoteSource') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'SOURCE: (' + @node_data.value('(./sp:RemoteScan/@RemoteSource)[1]', 'nvarchar(256)') + N')'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:RemoteScan/@RemoteObject') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + N'OBJECT: (' + @node_data.value('(./sp:RemoteScan/@RemoteObject)[1]', 'nvarchar(256)') + N')'
	end

	select @output = @output + N')'

	return @output;
end
