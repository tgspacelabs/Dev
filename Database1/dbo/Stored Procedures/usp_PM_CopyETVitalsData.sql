
-- Purpose: Copies vitals data related to ET Alarms for printing and reprinting. Used by the ICS_PrintJobDataCopier SqlAgentJob.
CREATE PROCEDURE [dbo].[usp_PM_CopyETVitalsData]
AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @preAlarmDataMinutes INT = 15; -- The number of minutes to grab vitals data before the start of the alarm... using this instead of tMinusPaddingSeconds for preAlarm in order to match what Clinical Access Alarms Tab does.

    DECLARE @tMinusPaddingSeconds INT; -- The number of seconds of waveform/vitals data after an alarm that we want to display/capture

    SELECT
        @tMinusPaddingSeconds = [Value]
    FROM
        [dbo].[ApplicationSettings]
    WHERE
        [ApplicationType] = 'Global'
        AND [Key] = 'PrintJobPaddingSeconds';

    IF @tMinusPaddingSeconds IS NULL
        RAISERROR(N'Global setting "%s" from the ApplicationSettings table was null or missing', 13, 1, N'PrintJobPaddingSeconds');

    MERGE [dbo].[int_print_job_et_vitals] AS [Target]
    USING
        (SELECT DISTINCT
            [PatientId],
            [VitalsData].[TopicSessionId],
            [GdsCode] AS [GDSCode],
            [VitalsData].[Name],
            [Value] AS [Value],
            [TimestampUTC] AS [ResultTimeUTC]
         FROM
            [dbo].[VitalsData]
            INNER JOIN [dbo].[GdsCodeMap] ON [GdsCodeMap].[FeedTypeId] = [VitalsData].[FeedTypeId]
                                             AND [GdsCodeMap].[Name] = [VitalsData].[Name]
            INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [VitalsData].[TopicSessionId]
            INNER JOIN [dbo].[int_print_job_et_alarm] ON [int_print_job_et_alarm].[DeviceSessionId] = [TopicSessions].[DeviceSessionId]
         WHERE
            [TimestampUTC] >= DATEADD(MINUTE, -@preAlarmDataMinutes, [AlarmStartTimeUTC])
            AND [TimestampUTC] <= DATEADD(SECOND, @tMinusPaddingSeconds, [AlarmEndTimeUTC])
        ) AS [Source]
    ON [Target].[TopicSessionId] = [Source].[TopicSessionId]
        AND [Target].[GDSCode] = [Source].[GDSCode]
        AND [Target].[ResultTimeUTC] = [Source].[ResultTimeUTC]
    WHEN NOT MATCHED THEN
        INSERT
               ([Id],
                [PatientId],
                [TopicSessionId],
                [GDSCode],
                [Name],
                [Value],
                [ResultTimeUTC]
	          )
        VALUES (NEWID(),
                [Source].[PatientId],
                [Source].[TopicSessionId],
                [Source].[GDSCode],
                [Source].[Name],
                [Source].[Value],
                [Source].[ResultTimeUTC]
	          );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Copies vitals data related to ET Alarms for printing and reprinting. Used by the ICS_PrintJobDataCopier SqlAgentJob.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PM_CopyETVitalsData';

