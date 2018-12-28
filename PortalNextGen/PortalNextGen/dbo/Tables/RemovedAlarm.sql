CREATE TABLE [dbo].[RemovedAlarm] (
    [RemovedAlarmID]  INT           IDENTITY (1, 1) NOT NULL,
    [AlarmID]         INT           NOT NULL,
    [RemovedFlag]     TINYINT       NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_RemovedAlarm_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_RemovedAlarm_RemovedAlarmID] PRIMARY KEY CLUSTERED ([RemovedAlarmID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_RemovedAlarm_AlarmID]
    ON [dbo].[RemovedAlarm]([AlarmID] ASC);

