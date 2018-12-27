CREATE EVENT SESSION [MonitorLog] ON SERVER 
ADD EVENT [sqlserver].[file_write_completed], 
ADD EVENT [sqlserver].[transaction_log] 
ADD TARGET [package0].[ring_buffer]
WITH  (
        MAX_MEMORY = 50 MB,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
        MAX_DISPATCH_LATENCY = 1 SECONDS,
        MEMORY_PARTITION_MODE = NONE,
        TRACK_CAUSALITY = OFF,
        STARTUP_STATE = OFF
      );

