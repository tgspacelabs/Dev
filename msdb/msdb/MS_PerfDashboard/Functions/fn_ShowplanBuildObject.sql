
create function MS_PerfDashboard.fn_ShowplanBuildObject (@node_data xml)
returns nvarchar(max)
as
begin
	declare @object nvarchar(max)
	set @object = N''

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Object/@Server') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @object = @object + @node_data.value('(./sp:Object/@Server)[1]', 'nvarchar(128)') + N'.'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Object/@Database') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @object = @object + @node_data.value('(./sp:Object/@Database)[1]', 'nvarchar(128)') + N'.'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Object/@Schema') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @object = @object + @node_data.value('(./sp:Object/@Schema)[1]', 'nvarchar(128)') + N'.'
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Object/@Table') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @object = @object + @node_data.value('(./sp:Object/@Table)[1]', 'nvarchar(128)')
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Object/@Index') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @object = @object + N'.' + @node_data.value('(./sp:Object/@Index)[1]', 'nvarchar(128)')
	end

	if (@node_data.exist('declare namespace sp="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; ./sp:Object/@Alias') = 1)
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @object = @object + N' AS ' + @node_data.value('(./sp:Object/@Alias)[1]', 'nvarchar(128)')
	end

	return @object
end
