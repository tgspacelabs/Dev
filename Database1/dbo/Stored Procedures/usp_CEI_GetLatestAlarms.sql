/* To get the latest Alarms for CEI*/
CREATE PROCEDURE [dbo].[usp_CEI_GetLatestAlarms]
    (
     @CutOffTimeUTC DATETIME,
     @locale VARCHAR(7) = 'en'
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [AllAlarms].[AlarmId] AS [AlarmId],
        [vpts].[PatientId] AS [PatientId],
        [AllAlarms].[WaveformFeedTypeId] AS [WaveformFeedTypeId],
        [AllAlarms].[StartDateTime] AS [StartDateTimeUTC],
        ISNULL([ar].[Message], ISNULL([ar].[AlarmTypeName], N'')) + CASE WHEN [ar].[ValueFormat] IS NOT NULL THEN ' ' + REPLACE([ar].[ValueFormat], N'{0}', [AllAlarms].[ViolatingValue])
                                                                         ELSE N''
                                                                    END + CASE WHEN [ar].[LimitFormat] IS NOT NULL THEN ' ' + REPLACE([ar].[LimitFormat], N'{0}', [AllAlarms].[SettingViolated])
                                                                               ELSE N''
                                                                          END AS [Title],
        [ar].[AlarmTypeName] AS [AlarmType],
        [AllAlarms].[SettingViolated] AS [SettingViolated],
        [AllAlarms].[ViolatingValue] AS [ViolatingValue],
        CASE WHEN [AllAlarms].[PriorityWeightValue] = 0 THEN 0     -- none/message
             WHEN [AllAlarms].[PriorityWeightValue] = 1 THEN 3     -- low
             WHEN [AllAlarms].[PriorityWeightValue] = 2 THEN 2     -- medium
             ELSE 1                                    -- high
        END AS [LegacyPriority],
        [SampleRate] AS [SampleRate],
        [DSIUnit].[Value] AS [organization_cd],
        [imm].[mrn_xid] AS [ID1],
        [imm].[mrn_xid2] AS [ID2],
        CONCAT([ip].[last_nm], N', ', [ip].[first_nm]) AS [PatientName],
        [DSIBed].[Value] AS [BedName]
    FROM
        (SELECT
            [lad].[AlarmId],
            [lad].[SettingViolated],
            [lad].[ViolatingValue],
            [lad].[StartDateTime],
            [lad].[PriorityWeightValue],
            [lad].[WaveformFeedTypeId],
            [lad].[TopicSessionId],
            [lad].[IDEnumValue],
            [lad].[EnumGroupId]
         FROM
            [dbo].[LimitAlarmsData] AS [lad]
         WHERE
            @CutOffTimeUTC < [lad].[AcquiredDateTimeUTC]
         UNION ALL
         SELECT
            [gad].[AlarmId],
            CAST(NULL AS VARCHAR(25)) AS [SettingViolated],
            CAST(NULL AS VARCHAR(25)) AS [ViolatingValue],
            [gad].[StartDateTime],
            [gad].[PriorityWeightValue],
            [gad].[WaveformFeedTypeId],
            [gad].[TopicSessionId],
            [gad].[IDEnumValue],
            [gad].[EnumGroupId]
         FROM
            [dbo].[GeneralAlarmsData] AS [gad]
         WHERE
            @CutOffTimeUTC < [gad].[AcquiredDateTimeUTC]
        ) AS [AllAlarms]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [vpts].[TopicSessionId] = [AllAlarms].[TopicSessionId]
        INNER JOIN [dbo].[TopicSessions] AS [ts] ON [ts].[Id] = [AllAlarms].[TopicSessionId]
        INNER JOIN [dbo].[AlarmResources] AS [ar] ON [ar].[Locale] = @locale
                                                     AND [ar].[EnumGroupId] = [AllAlarms].[EnumGroupId]
                                                     AND [ar].[IDEnumValue] = [AllAlarms].[IDEnumValue]
        INNER JOIN [dbo].[int_mrn_map] AS [imm] ON [imm].[patient_id] = [vpts].[PatientId]
        INNER JOIN [dbo].[int_person] AS [ip] ON [ip].[person_id] = [imm].[patient_id]
        INNER JOIN [dbo].[TopicFeedTypes] ON [FeedTypeId] = [AllAlarms].[WaveformFeedTypeId]
        INNER JOIN [dbo].[v_DeviceSessionInfo] AS [DSIBed] ON [DSIBed].[DeviceSessionId] = [ts].[DeviceSessionId]
                                                              AND [DSIBed].[Name] = N'Bed'
        INNER JOIN [dbo].[v_DeviceSessionInfo] AS [DSIUnit] ON [DSIUnit].[DeviceSessionId] = [ts].[DeviceSessionId]
                                                               AND [DSIUnit].[Name] = N'Unit';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the latest Alarms for CEI.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CEI_GetLatestAlarms';

