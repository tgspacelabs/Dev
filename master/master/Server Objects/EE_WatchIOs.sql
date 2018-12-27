CREATE EVENT SESSION [EE_WatchIOs] ON SERVER 
ADD EVENT [sqlserver].[sql_statement_completed]
    (
    ACTION ([sqlserver].[sql_text])
    ) 
ADD TARGET [package0].[event_file]
    (
    SET FILENAME = N'C:\Temp\EE_WatchIOs.xel',
        METADATAFILE = N'C:\Temp\EE_WatchIOs.xem'
    )
WITH  (
        MAX_MEMORY = 4 MB,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 1 SECONDS,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
      );

