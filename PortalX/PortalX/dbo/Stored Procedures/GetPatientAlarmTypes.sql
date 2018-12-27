CREATE PROCEDURE [dbo].[GetPatientAlarmTypes]
    (
    @patient_id UNIQUEIDENTIFIER,
    @start_ft BIGINT,
    @end_ft BIGINT)
AS
BEGIN
    DECLARE
        @start_dt DATETIME = [dbo].[fnFileTimeToDateTime](@start_ft),
        @end_dt DATETIME = [dbo].[fnFileTimeToDateTime](@end_ft);

    SELECT DISTINCT
           [ict].[channel_code] AS [TYPE],
           [ia].[alarm_cd] AS [TITLE]
    FROM [dbo].[int_alarm] AS [ia]
        INNER JOIN [dbo].[int_patient_channel] AS [ipc]
            ON [ia].[patient_channel_id] = [ipc].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] AS [ict]
            ON [ipc].[channel_type_id] = [ict].[channel_type_id]
    WHERE [ia].[patient_id] = @patient_id
          AND [ia].[alarm_level] > 0
          AND ((@start_ft < [ia].[end_ft]
                AND @end_ft >= [ia].[start_ft])
               OR (@end_ft >= [ia].[start_ft]
                   AND [ia].[end_ft] IS NULL))
    UNION ALL
    SELECT
        [vga].[ChannelCode] AS [TYPE],
        [vga].[Title] AS [TITLE]
    FROM [dbo].[v_GeneralAlarms] AS [vga]
    WHERE [vga].[AlarmId] IN (SELECT [gad].[AlarmId]
                              FROM [dbo].[GeneralAlarmsData] AS [gad]
                              WHERE [gad].[TopicSessionId] IN (SELECT [vpts].[TopicSessionId]
                                                               FROM [dbo].[v_PatientTopicSessions] AS [vpts]
                                                               WHERE [vpts].[PatientId] = @patient_id)
                                    AND ((@start_dt < [gad].[EndDateTime]
                                          AND @end_dt >= [gad].[StartDateTime])
                                         OR (@end_dt >= [gad].[StartDateTime]
                                             AND [gad].[EndDateTime] IS NULL))
                                    AND [gad].[PriorityWeightValue] > 0)
    UNION ALL
    SELECT
        [vla].[ChannelCode] AS [TYPE],
        [vla].[AlarmType] AS [TITLE]
    FROM [dbo].[v_LimitAlarms] AS [vla]
    WHERE [vla].[AlarmId] IN (SELECT [lad].[AlarmId]
                              FROM [dbo].[LimitAlarmsData] AS [lad]
                              WHERE [lad].[TopicSessionId] IN (SELECT [vpts].[TopicSessionId]
                                                               FROM [dbo].[v_PatientTopicSessions] AS [vpts]
                                                               WHERE [vpts].[PatientId] = @patient_id)
                                    AND ((@start_dt < [lad].[EndDateTime]
                                          AND @end_dt >= [lad].[StartDateTime])
                                         OR (@end_dt >= [lad].[StartDateTime]
                                             AND [lad].[EndDateTime] IS NULL))
                                    AND [lad].[PriorityWeightValue] > 0);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientAlarmTypes';

