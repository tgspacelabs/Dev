
create procedure MS_PerfDashboard.usp_Main_GetRequestWaits
as
begin
	SELECT 
		r.session_id, 
		MS_PerfDashboard.fn_WaitTypeCategory(r.wait_type) AS wait_category, 
		r.wait_type, 
		r.wait_time
	FROM sys.dm_exec_requests AS r 
		INNER JOIN sys.dm_exec_sessions AS s ON r.session_id = s.session_id
	WHERE r.wait_type IS NOT NULL  
		AND s.is_user_process = 0x1		-- TODO: parameterize
end
