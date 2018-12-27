CREATE EVENT SESSION [LockCounts] ON SERVER 
ADD EVENT [sqlserver].[lock_acquired]
    (
    WHERE ([database_id]=(31))
    ) 
ADD TARGET [package0].[histogram]
    (
    SET filtering_event_name = 'sqlserver.lock_acquired',
        source = 'resource_0',
        source_type = 0
    )
WITH  (
        MAX_MEMORY = 4 MB,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 30 SECONDS,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
      );

