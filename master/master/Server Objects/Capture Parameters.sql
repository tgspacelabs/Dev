CREATE EVENT SESSION [Capture Parameters] ON SERVER 
ADD EVENT [sqlserver].[rpc_completed]
    (
    SET collect_output_parameters = 1,
        collect_statement = 1
    ACTION ([sqlserver].[client_app_name],
            [sqlserver].[client_hostname],
            [sqlserver].[database_id],
            [sqlserver].[database_name],
            [sqlserver].[query_hash],
            [sqlserver].[query_plan_hash],
            [sqlserver].[sql_text])
    WHERE ([sqlserver].[database_id]=(5))
    ), 
ADD EVENT [sqlserver].[sql_batch_completed]
    (
    ACTION ([sqlserver].[client_app_name],
            [sqlserver].[client_hostname],
            [sqlserver].[database_id],
            [sqlserver].[database_name],
            [sqlserver].[query_hash],
            [sqlserver].[query_plan_hash],
            [sqlserver].[sql_text])
    WHERE ([sqlserver].[database_id]=(5))
    ) 
ADD TARGET [package0].[event_file]
    (
    SET filename = N'Capture Parameters',
        max_rollover_files = 0
    )
WITH  (
        MAX_MEMORY = 4 MB,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 30 SECONDS,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
      );

