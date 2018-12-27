﻿CREATE EVENT SESSION [blocked_process] ON SERVER 
ADD EVENT [sqlserver].[blocked_process_report]
    (
    ACTION ([sqlserver].[client_app_name],
            [sqlserver].[client_hostname],
            [sqlserver].[database_name])
    ), 
ADD EVENT [sqlserver].[xml_deadlock_report]
    (
    ACTION ([sqlserver].[client_app_name],
            [sqlserver].[client_hostname],
            [sqlserver].[database_name])
    ) 
ADD TARGET [package0].[event_file]
    (
    SET filename = N'c:\temp\XEventSessions\blocked_process.xel',
        max_file_size = 65536,
        max_rollover_files = 5,
        metadatafile = N'c:\temp\XEventSessions\blocked_process.xem'
    )
WITH  (
        MAX_MEMORY = 4 MB,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 5 SECONDS,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
      );

