CREATE EVENT SESSION [PageLocks] ON SERVER 
ADD EVENT [sqlserver].[lock_acquired]
    (
    SET collect_database_name = 1,
        collect_resource_description = 1
    ACTION ([sqlserver].[database_id],
            [sqlserver].[database_name],
            [sqlserver].[query_hash],
            [sqlserver].[query_plan_hash],
            [sqlserver].[sql_text])
    WHERE ([database_name]=N'portal' AND [resource_type]=(6))
    ), 
ADD EVENT [sqlserver].[lock_released]
    (
    SET collect_database_name = 1,
        collect_resource_description = 1
    ACTION ([sqlserver].[database_id],
            [sqlserver].[database_name],
            [sqlserver].[query_hash],
            [sqlserver].[query_plan_hash],
            [sqlserver].[sql_text])
    WHERE ([database_name]=N'portal' AND [resource_type]=(6))
    ) 
ADD TARGET [package0].[event_file]
    (
    SET filename = N'C:\T\PageLock.xel',
        max_rollover_files = 10
    )
WITH  (
        MAX_MEMORY = 4 MB,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 30 SECONDS,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
      );

