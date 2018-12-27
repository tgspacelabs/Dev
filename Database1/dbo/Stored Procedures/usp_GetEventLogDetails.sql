
CREATE PROCEDURE [dbo].[usp_GetEventLogDetails]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [type],
        [event_dt],
        [description],
        [status],
        [event_origin].[monitor_name],
        [event_origin].[first_nm],
        [event_origin].[middle_nm],
        [event_origin].[last_nm]
    FROM
        [dbo].[int_event_log]
        INNER JOIN (SELECT
                        [alarm_id] AS [event_id],
                        [monitor_name],
                        [first_nm],
                        [middle_nm],
                        [last_nm]
                    FROM
                        [dbo].[int_alarm]
                        INNER JOIN [dbo].[int_patient_monitor] ON [int_patient_monitor].[patient_id] = [int_alarm].[patient_id]
                        INNER JOIN [dbo].[int_monitor] ON [int_monitor].[monitor_id] = [int_patient_monitor].[monitor_id]
                        INNER JOIN [dbo].[int_person] ON [person_id] = [int_alarm].[patient_id]
                    UNION
                    SELECT
                        [AlarmId] AS [event_id],
                        [MonitorName] AS [monitor_name],
                        [FIRST_NAME] AS [first_nm],
                        [MIDDLE_NAME] AS [middle_nm],
                        [LAST_NAME] AS [last_nm]
                    FROM
                        [dbo].[v_LimitAlarms]
                        INNER JOIN [dbo].[v_DeviceSessionAssignment] ON [v_DeviceSessionAssignment].[DeviceSessionId] = [v_LimitAlarms].[DeviceSessionId]
                        INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId] = [v_LimitAlarms].[TopicSessionId]
                        INNER JOIN [dbo].[v_Patients] ON [PATIENT_ID] = [v_PatientTopicSessions].[PatientId]
                    UNION
                    SELECT
                        [AlarmId] AS [event_id],
                        [MonitorName] AS [monitor_name],
                        [FIRST_NAME] AS [first_nm],
                        [MIDDLE_NAME] AS [middle_nm],
                        [LAST_NAME] AS [last_nm]
                    FROM
                        [dbo].[v_GeneralAlarms]
                        INNER JOIN [dbo].[v_DeviceSessionAssignment] ON [v_DeviceSessionAssignment].[DeviceSessionId] = [v_GeneralAlarms].[DeviceSessionId]
                        INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId] = [v_GeneralAlarms].[TopicSessionId]
                        INNER JOIN [dbo].[v_Patients] ON [PATIENT_ID] = [v_PatientTopicSessions].[PatientId]
                   ) AS [event_origin] ON [event_origin].[event_id] = [int_event_log].[event_id]
    ORDER BY
        [event_dt];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetEventLogDetails';

