CREATE EVENT SESSION [Filtered Event] ON SERVER 
ADD EVENT [sqlserver].[sql_batch_completed]
    (
    SET collect_batch_text = 1
    WHERE ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'AdventureWorks') AND [sqlserver].[like_i_sql_unicode_string]([batch_text],N'%uspGetBillOfMaterials%') AND [sqlserver].[like_i_sql_unicode_string]([batch_text],N'%@StartProductID = 723%'))
    )
WITH  (
        MAX_MEMORY = 4 MB,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 30 SECONDS,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
      );

