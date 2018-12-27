
CREATE function [MS_PerfDashboard].[fn_ShowplanBuildSeekPredicatesNew] (@node_data xml)
returns nvarchar(max)
as
begin
	declare @output nvarchar(max)
	declare @count int, @ctr int

	;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
	select @output = N'', @ctr = 1, @count = @node_data.value('count(./sp:SeekPredicates/sp:SeekPredicateNew)', 'int')
	
	-- iterate over each element in the list
	while @ctr <= @count
	begin
		;WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS sp)
		select @output = @output + case when @ctr > 1 then N' AND ' else N'' end + MS_PerfDashboard.fn_ShowplanBuildSeekPredicate(@node_data.query('./sp:SeekPredicates/sp:SeekPredicateNew/sp:SeekKeys[position() = sql:variable("@ctr")]/*'))

		select @ctr = @ctr + 1
	end

	return @output
end
