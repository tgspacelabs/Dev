
create function MS_PerfDashboard.fn_ShowplanBuildColumnReference(@node_data xml, @include_alias_or_table bit)
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)
	declare @table nvarchar(256), @alias nvarchar(256), @column nvarchar(256)

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @alias = @node_data.value('(./sp:ColumnReference/@Alias)[1]', 'nvarchar(256)'),
		@table = @node_data.value('(./sp:ColumnReference/@Table)[1]', 'nvarchar(256)'),
		@column = @node_data.value('(./sp:ColumnReference/@Column)[1]', 'nvarchar(256)')

	select @column = case when left(@column, 1) = N'[' and right(@column, 1) = N']' then @column else quotename(@column) end

	if @include_alias_or_table = 0x1 and coalesce(@alias, @table) is not null
	begin
		select @alias = case when left(@alias, 1) = N'[' and right(@alias, 1) = N']' then @alias else quotename(@alias) end
		select @table = case when left(@table, 1) = N'[' and right(@table, 1) = N']' then @table else quotename(@table) end

		select @output = case 
					when @alias is not null then @alias
					else @table
				end + N'.' + @column
	end
	else
	begin
		select @output = @column
	end

	return @output
end
