CREATE TABLE [dbo].[TopicSessions] (
    [Id]               UNIQUEIDENTIFIER NOT NULL,
    [TopicTypeId]      UNIQUEIDENTIFIER NULL,
    [TopicInstanceId]  UNIQUEIDENTIFIER NULL,
    [DeviceSessionId]  UNIQUEIDENTIFIER NULL,
    [PatientSessionId] UNIQUEIDENTIFIER NULL,
    [BeginTimeUTC]     DATETIME         NULL,
    [EndTimeUTC]       DATETIME         NULL,
    CONSTRAINT [PK_TopicSessions_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE CLUSTERED INDEX [idxc_TopicSessions_1]
    ON [dbo].[TopicSessions]([PatientSessionId] ASC, [BeginTimeUTC] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSessions_PatientSessionId]
    ON [dbo].[TopicSessions]([PatientSessionId] ASC, [Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSessions_TopicType]
    ON [dbo].[TopicSessions]([TopicTypeId] ASC);


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
