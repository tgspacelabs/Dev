

CREATE PROCEDURE [dbo].[GetPatientAlarmTypes]
    (
     @patient_id UNIQUEIDENTIFIER,
     @start_ft BIGINT,
     @end_ft BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
      DISTINCT
        [channel_code] AS [TYPE],
        [alarm_cd] AS [TITLE]
    FROM
        [dbo].[int_alarm]
        INNER JOIN [dbo].[int_patient_channel] ON [int_alarm].[patient_channel_id] = [int_patient_channel].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] ON [int_patient_channel].[channel_type_id] = [int_channel_type].[channel_type_id]
    WHERE
        [int_alarm].[patient_id] = @patient_id
        AND [alarm_level] > 0
        AND ((@start_ft < [end_ft]
        AND @end_ft >= [start_ft]
        )
        OR (@end_ft >= [start_ft]
        AND [end_ft] IS NULL
        )
        )
    UNION ALL
    SELECT
        [ChannelCode] AS [TYPE],
        [Title] AS [TITLE]
    FROM
        [dbo].[v_GeneralAlarms]
    WHERE
        [AlarmId] IN (SELECT
                        [AlarmId]
                      FROM
                        [dbo].[GeneralAlarmsData]
                      WHERE
                        [TopicSessionId] IN (SELECT
                                                [TopicSessionId]
                                             FROM
                                                [dbo].[v_PatientTopicSessions]
                                             WHERE
                                                [PatientId] = @patient_id)
                        AND (([dbo].[fnFileTimeToDateTime](@start_ft) < [EndDateTime]
                        AND [dbo].[fnFileTimeToDateTime](@end_ft) >= [StartDateTime]
                        )
                        OR ([dbo].[fnFileTimeToDateTime](@end_ft) >= [StartDateTime]
                        AND [EndDateTime] IS NULL
                        )
                        )
                        AND [PriorityWeightValue] > 0)
    UNION ALL
    SELECT
        [ChannelCode] AS [TYPE],
        [AlarmType] AS [TITLE]
    FROM
        [dbo].[v_LimitAlarms]
    WHERE
        [AlarmId] IN (SELECT
                        [AlarmId]
                      FROM
                        [dbo].[LimitAlarmsData]
                      WHERE
                        [TopicSessionId] IN (SELECT
                                                [TopicSessionId]
                                             FROM
                                                [dbo].[v_PatientTopicSessions]
                                             WHERE
                                                [PatientId] = @patient_id)
                        AND (([dbo].[fnFileTimeToDateTime](@start_ft) < [EndDateTime]
                        AND [dbo].[fnFileTimeToDateTime](@end_ft) >= [StartDateTime]
                        )
                        OR ([dbo].[fnFileTimeToDateTime](@end_ft) >= [StartDateTime]
                        AND [EndDateTime] IS NULL
                        )
                        )
                        AND [PriorityWeightValue] > 0);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientAlarmTypes';

