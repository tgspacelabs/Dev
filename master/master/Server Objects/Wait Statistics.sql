CREATE EVENT SESSION [Wait Statistics] ON SERVER 
ADD EVENT [sqlos].[wait_completed]
    (
    SET collect_wait_resource = 1
    ACTION ([sqlserver].[database_id],
            [sqlserver].[database_name],
            [sqlserver].[is_system],
            [sqlserver].[session_id])
    WHERE ([sqlserver].[database_id]>(5) AND [sqlserver].[is_system]<>(0))
    ), 
ADD EVENT [sqlos].[wait_info]
    (
    ACTION ([sqlserver].[database_id],
            [sqlserver].[database_name],
            [sqlserver].[is_system],
            [sqlserver].[session_id])
    WHERE ([sqlserver].[database_id]>(5) AND [sqlserver].[is_system]<>(0))
    ), 
ADD EVENT [sqlos].[wait_info_external]
    (
    ACTION ([sqlserver].[database_id],
            [sqlserver].[database_name],
            [sqlserver].[is_system],
            [sqlserver].[session_id])
    WHERE ([sqlserver].[database_id]>(5) AND [sqlserver].[is_system]<>(0))
    ) 
ADD TARGET [package0].[ring_buffer]
    (
    SET max_memory = 102400
    )
WITH  (
        MAX_MEMORY = 4 MB,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 30 SECONDS,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
      );

