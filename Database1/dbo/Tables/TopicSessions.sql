CREATE TABLE [dbo].[TopicSessions] (
    [Id]               UNIQUEIDENTIFIER NOT NULL,
    [TopicTypeId]      UNIQUEIDENTIFIER NULL,
    [TopicInstanceId]  UNIQUEIDENTIFIER NULL,
    [DeviceSessionId]  UNIQUEIDENTIFIER NULL,
    [PatientSessionId] UNIQUEIDENTIFIER NULL,
    [BeginTimeUTC]     DATETIME         NULL,
    [EndTimeUTC]       DATETIME         NULL,
    CONSTRAINT [PK_TopicSessions_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSessions_DeviceSessionId_Id]
    ON [dbo].[TopicSessions]([DeviceSessionId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSessions_PatientSessionId_BeginTimeUTC]
    ON [dbo].[TopicSessions]([PatientSessionId] ASC, [BeginTimeUTC] ASC) WITH (FILLFACTOR = 100);


GO

CREATE TRIGGER [dbo].[trig_TopicSessions_CloseAlarms]
ON [dbo].[TopicSessions]
FOR INSERT, UPDATE
AS
BEGIN
	SELECT  [TopicSessionId]
	       ,MAX([EndTimeUTC]) AS [EndTimeUTC]
		INTO #ClosingTimes
		FROM
		(
			SELECT inserted.[Id] AS [TopicSessionId], [EndTimeUTC]
				FROM inserted
				WHERE [EndTimeUTC] IS NOT NULL
		) AS [TopicSessionUpdatesWithEndTime]
		GROUP BY [TopicSessionId]

	UPDATE
		[dbo].[GeneralAlarmsData]
		SET [EndDateTime] = [Src].[EndTimeUTC]
		FROM #ClosingTimes AS [Src]
		WHERE [GeneralAlarmsData].[TopicSessionId] = [Src].[TopicSessionId]
		AND [GeneralAlarmsData].[EndDateTime] IS NULL

	UPDATE
		[dbo].[LimitAlarmsData]
		SET [EndDateTime] = [Src].[EndTimeUTC]
		FROM #ClosingTimes AS [Src]
		WHERE [LimitAlarmsData].[TopicSessionId] = [Src].[TopicSessionId]
		AND [LimitAlarmsData].[EndDateTime] IS NULL
END

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TopicSessions';

