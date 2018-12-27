CREATE TABLE [dbo].[RemovedAlarms] (
    [AlarmId] UNIQUEIDENTIFIER NOT NULL,
    [Removed] TINYINT          NULL,
    CONSTRAINT [PK_RemovedAlarms_AlarmId] PRIMARY KEY CLUSTERED ([AlarmId] ASC)
);

