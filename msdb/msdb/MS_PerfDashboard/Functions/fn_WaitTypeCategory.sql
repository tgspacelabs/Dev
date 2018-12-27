
create function MS_PerfDashboard.fn_WaitTypeCategory(@wait_type nvarchar(60)) 
returns varchar(60)
as
begin
	declare @category nvarchar(60)
	select @category = 
		case 
			when @wait_type = N'SOS_SCHEDULER_YIELD' then N'CPU'
			when @wait_type = N'THREADPOOL' then N'Worker Thread'
			when @wait_type like N'LCK_M_%' then N'Lock'
			when @wait_type like N'LATCH_%' then N'Latch'
			when @wait_type like N'PAGELATCH_%' then N'Buffer Latch'
			when @wait_type like N'PAGEIOLATCH_%' then N'Buffer IO'
			when @wait_type like N'RESOURCE_SEMAPHORE_%' then N'Compilation'
			when @wait_type like N'CLR_%' or @wait_type like N'SQLCLR%' then N'SQL CLR'
			when @wait_type like N'DBMIRROR%' or @wait_type = N'MIRROR_SEND_MESSAGE' then N'Mirroring'
			when @wait_type like N'XACT%' or @wait_type like N'DTC_%' or @wait_type like N'TRAN_MARKLATCH_%' or @wait_type like N'MSQL_XACT_%' or @wait_type = N'TRANSACTION_MUTEX' then N'Transaction'
			when @wait_type like N'SLEEP_%' or @wait_type in(N'LAZYWRITER_SLEEP', N'SQLTRACE_BUFFER_FLUSH', N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP', N'SQLTRACE_WAIT_ENTRIES', N'FT_IFTS_SCHEDULER_IDLE_WAIT', N'XE_DISPATCHER_WAIT', N'REQUEST_FOR_DEADLOCK_SEARCH', N'SLEEP_TASK', N'LOGMGR_QUEUE', N'ONDEMAND_TASK_QUEUE', N'CHECKPOINT_QUEUE', N'XE_TIMER_EVENT') then N'Idle'
			when @wait_type like N'PREEMPTIVE_%' then N'Preemptive'
			when @wait_type like N'BROKER_%' then N'Service Broker'
			when @wait_type in (N'LOGMGR', N'LOGBUFFER', N'LOGMGR_RESERVE_APPEND', N'LOGMGR_FLUSH', N'WRITELOG') then N'Tran Log IO'
			when @wait_type in (N'ASYNC_NETWORK_IO', N'NET_WAITFOR_PACKET') then N'Network IO'
			when @wait_type in (N'CXPACKET', N'EXCHANGE') then N'Parallelism'
			when @wait_type in (N'RESOURCE_SEMAPHORE', N'CMEMTHREAD', N'SOS_RESERVEDMEMBLOCKLIST') then N'Memory'
			when @wait_type in (N'WAITFOR', N'WAIT_FOR_RESULTS', N'BROKER_RECEIVE_WAITFOR') then N'User Wait'
			when @wait_type in (N'TRACEWRITE', N'SQLTRACE_LOCK', N'SQLTRACE_FILE_BUFFER', N'SQLTRACE_FILE_WRITE_IO_COMPLETION') then N'Tracing'
			when @wait_type in (N'FT_RESTART_CRAWL', N'FULLTEXT GATHERER', N'MSSEARCH') then N'Full Text Search'
			when @wait_type in (N'ASYNC_IO_COMPLETION', N'IO_COMPLETION', N'BACKUPIO', N'WRITE_COMPLETION') then N'Other Disk IO'
			else N'Other'
		end

	return @category
end
