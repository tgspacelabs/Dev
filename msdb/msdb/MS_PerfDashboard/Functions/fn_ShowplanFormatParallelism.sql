
CREATE FUNCTION MS_PerfDashboard.fn_ShowplanFormatParallelism(@node_data xml, @logical_op nvarchar(128))
RETURNS nvarchar(max)
as
begin
	declare @output nvarchar(max)

	select @output = N'Parallelism(' + @logical_op + N')'
	--TODO: Extend to show partitioning information, order by information	

	return @output;
end
