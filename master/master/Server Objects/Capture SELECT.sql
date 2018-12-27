CREATE EVENT SESSION [Capture SELECT] ON SERVER 
ADD EVENT [sqlserver].[sql_statement_completed]
    (
    SET collect_parameterized_plan_handle = 1,
        collect_statement = 1
    ACTION ([sqlserver].[database_id],
            [sqlserver].[database_name],
            [sqlserver].[sql_text])
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'AdventureWorks') AND [sqlserver].[like_i_sql_unicode_string]([statement],N'%Person.Address%'))
    ) 
ADD TARGET [package0].[event_file]
    (
    SET filename = N'Capture SELECT',
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

