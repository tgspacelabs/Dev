CREATE TABLE [dbo].[TopicSessions] (
    [Id]               BIGINT NOT NULL,
    [TopicTypeId]      BIGINT NULL,
    [TopicInstanceId]  BIGINT NULL,
    [DeviceSessionId]  BIGINT NULL,
    [PatientSessionId] BIGINT NULL,
    [BeginTimeUTC]     DATETIME         NULL,
    [EndTimeUTC]       DATETIME         NULL,
    CONSTRAINT [PK_TopicSessions_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_TopicSessions_PatientSessionId_TopicInstanceId_BeginTimeUTC]
    ON [dbo].[TopicSessions]([PatientSessionId] ASC, [TopicInstanceId] ASC, [BeginTimeUTC] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_TopicSessions_PatientSessionId_Id_DeviceSessionId]
    ON [dbo].[TopicSessions]([PatientSessionId] ASC, [Id] ASC, [DeviceSessionId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE TRIGGER [dbo].[trg_TopicSessions_CloseAlarms] ON [dbo].[TopicSessions]
    FOR INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [TopicSessionUpdatesWithEndTime].[TopicSessionId],
        MAX([TopicSessionUpdatesWithEndTime].[EndTimeUTC]) AS [EndTimeUTC]
    INTO
        [#ClosingTimes]
    FROM
        (SELECT
            [Inserted].[Id] AS [TopicSessionId],
            [Inserted].[EndTimeUTC]
         FROM
            [Inserted]
         WHERE
            [Inserted].[EndTimeUTC] IS NOT NULL
        ) AS [TopicSessionUpdatesWithEndTime]
    GROUP BY
        [TopicSessionUpdatesWithEndTime].[TopicSessionId];

    UPDATE
        [dbo].[GeneralAlarmsData]
    SET
        [EndDateTime] = [Src].[EndTimeUTC]
    FROM
        [#ClosingTimes] AS [Src]
    WHERE
        [GeneralAlarmsData].[TopicSessionId] = [Src].[TopicSessionId]
        AND [GeneralAlarmsData].[EndDateTime] IS NULL;

    UPDATE
        [dbo].[LimitAlarmsData]
    SET
        [EndDateTime] = [Src].[EndTimeUTC]
    FROM
        [#ClosingTimes] AS [Src]
    WHERE
        [LimitAlarmsData].[TopicSessionId] = [Src].[TopicSessionId]
        AND [LimitAlarmsData].[EndDateTime] IS NULL;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TopicSessions';

