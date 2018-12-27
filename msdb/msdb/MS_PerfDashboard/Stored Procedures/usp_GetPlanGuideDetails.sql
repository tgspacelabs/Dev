
create procedure MS_PerfDashboard.usp_GetPlanGuideDetails @database_name nvarchar(128), @plan_guide_name nvarchar(128)
as
begin
	if (LEFT(@database_name, 1) = N'[' and RIGHT(@database_name, 1) = N']')
	begin
		select @database_name = substring(@database_name, 2, len(@database_name) - 2)
	end

	if (LEFT(@plan_guide_name, 1) = N'[' and RIGHT(@plan_guide_name, 1) = N']')
	begin
		select @plan_guide_name = substring(@plan_guide_name, 2, len(@plan_guide_name) - 2)
	end

	if db_id(@database_name) is not null
	begin
		declare @cmd nvarchar(4000)
		select @cmd = N'select * from [' + @database_name + N'].[sys].[plan_guides] where name = @P1'

		exec sp_executesql @cmd, N'@P1 nvarchar(128)', @plan_guide_name
	end
	else
	begin
		-- return empty result set
		select * from [sys].[plan_guides] where 0 = 1
	end
end
