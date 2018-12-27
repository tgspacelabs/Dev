
CREATE PROCEDURE [dbo].[GetPatientAlarms]
    (
     @patient_id UNIQUEIDENTIFIER,
     @start_ft BIGINT,
     @end_ft BIGINT,
     @locale VARCHAR(7) = 'en'
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @end_dt DATETIME = [dbo].[fnFileTimeToDateTime](@end_ft);
    DECLARE @start_dt DATETIME = [dbo].[fnFileTimeToDateTime](@start_ft);
    DECLARE @locale_arg VARCHAR(7) = @locale;
    DECLARE @patient_id_arg UNIQUEIDENTIFIER = @patient_id;

    SELECT
        [ia].[alarm_id] AS [Id],
        [ict].[channel_code] AS [TYPE],
        ISNULL([ia].[alarm_cd], N'') AS [TypeString],
        ISNULL([ia].[alarm_cd], N'') AS [TITLE],
        [ia].[start_ft] AS [START_FT],
        [ia].[end_ft] AS [END_FT],
        [ia].[start_dt] AS [START_DT],
        [ia].[removed] AS [Removed],
        [ia].[alarm_level] AS [PRIORITY],
        CAST('' AS NVARCHAR(250)) AS [Label]
    FROM
        [dbo].[int_alarm] AS [ia]
        INNER JOIN [dbo].[int_patient_channel] AS [ipc] ON [ia].[patient_channel_id] = [ipc].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] AS [ict] ON [ipc].[channel_type_id] = [ict].[channel_type_id]
    WHERE
        [ia].[patient_id] = @patient_id_arg
        AND [ia].[alarm_level] > 0
        AND (@start_ft < [END_FT]
        OR [END_FT] IS NULL
        )
    UNION ALL
    SELECT
        [lad].[AlarmId] AS [Id],
        [tft].[ChannelCode] AS [TYPE],
        ISNULL([ar].[Message], [ar].[AlarmTypeName]) AS [TypeString],
        ISNULL([ar].[Message], N'') + N'  ' + REPLACE(ISNULL([ar].[ValueFormat], N''), N'{0}', [lad].[ViolatingValue]) + N'  ' + REPLACE(ISNULL([ar].[LimitFormat], N''), N'{0}', [lad].[SettingViolated]) AS [Title],
        [dbo].[fnDateTimeToFileTime]([lad].[StartDateTime]) AS [START_FT],
        [dbo].[fnDateTimeToFileTime]([lad].[EndDateTime]) AS [END_FT],
        CAST(NULL AS DATETIME) AS [START_DT],
        [ra].[Removed],
        CASE WHEN [lad].[PriorityWeightValue] = 0 THEN 0  -- none/message
             WHEN [lad].[PriorityWeightValue] = 1 THEN 3  -- low
             WHEN [lad].[PriorityWeightValue] = 2 THEN 2  -- medium
             ELSE 1                                 -- high
        END AS [PRIORITY],
        CAST(N'' AS NVARCHAR(250)) AS [Label]
    FROM
        [dbo].[LimitAlarmsData] AS [lad]
        INNER JOIN [dbo].[AlarmResources] AS [ar] ON [ar].[EnumGroupId] = [lad].[EnumGroupId]
                                                     AND [ar].[IDEnumValue] = [lad].[IDEnumValue]
                                                     AND [ar].[Locale] = @locale_arg
        INNER JOIN [dbo].[TopicFeedTypes] AS [tft] ON [tft].[FeedTypeId] = [lad].[WaveformFeedTypeId]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [vpts].[TopicSessionId] = [lad].[TopicSessionId]
        LEFT OUTER JOIN [dbo].[RemovedAlarms] AS [ra] ON [ra].[AlarmId] = [lad].[AlarmId]
    WHERE
        [vpts].[PatientId] = @patient_id_arg
        AND [lad].[StartDateTime] <= @end_dt
        AND ([lad].[EndDateTime] IS NULL
        OR @start_dt <= [lad].[EndDateTime]
        )
    UNION ALL
    SELECT
        [gad].[AlarmId] AS [Id],
        [tft].[ChannelCode] AS [TYPE],
        ISNULL([ar].[Message], [ar].[AlarmTypeName]) AS [TypeString],
        ISNULL([ar].[Message], N'') AS [Title],
        [dbo].[fnDateTimeToFileTime]([gad].[StartDateTime]) AS [START_FT],
        [dbo].[fnDateTimeToFileTime]([gad].[EndDateTime]) AS [END_FT],
        CAST(NULL AS DATETIME) AS [START_DT],
        [ra].[Removed],
        CASE WHEN [gad].[PriorityWeightValue] = 0 THEN 0  -- none/message
             WHEN [gad].[PriorityWeightValue] = 1 THEN 3  -- low
             WHEN [gad].[PriorityWeightValue] = 2 THEN 2  -- medium
             ELSE 1                                       -- high
        END AS [PRIORITY],
        CAST(N'' AS NVARCHAR(250)) AS [Label]
    FROM
        [dbo].[GeneralAlarmsData] AS [gad]
        INNER JOIN [dbo].[AlarmResources] AS [ar] ON [ar].[EnumGroupId] = [gad].[EnumGroupId]
                                                     AND [ar].[IDEnumValue] = [gad].[IDEnumValue]
                                                     AND [ar].[Locale] = @locale_arg
        INNER JOIN [dbo].[TopicFeedTypes] AS [tft] ON [tft].[FeedTypeId] = [gad].[WaveformFeedTypeId]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [vpts].[TopicSessionId] = [gad].[TopicSessionId]
        LEFT OUTER JOIN [dbo].[RemovedAlarms] AS [ra] ON [ra].[AlarmId] = [gad].[AlarmId]
    WHERE
        [vpts].[PatientId] = @patient_id_arg
        AND [gad].[StartDateTime] <= @end_dt
        AND ([gad].[EndDateTime] IS NULL
        OR @start_dt <= [gad].[EndDateTime]
        )
    ORDER BY
        [START_FT];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientAlarms';

