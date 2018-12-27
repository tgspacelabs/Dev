
create function MS_PerfDashboard.fn_DatediffMilliseconds(@start datetime, @end datetime) 
returns bigint 
as 
begin 
	return (datediff(dd, @start, @end) * cast(86400000 as bigint) + datediff(ms, dateadd(dd, datediff(dd, @start, @end), @start), @end))
end
