CREATE PROCEDURE [dbo].[usp_GetEventLogDetails]
AS
  BEGIN
    SELECT
        int_event_log.type,
                                int_event_log.event_dt, 
                                int_event_log.description, 
                                int_event_log.status, 
                                event_origin.monitor_name,
                                event_origin.first_nm, 
                                event_origin.middle_nm, 
                                event_origin.last_nm 						
    FROM int_event_log
								INNER JOIN
								(
									SELECT
										alarm_id AS event_id,
										int_monitor.monitor_name,
										int_person.first_nm,
										int_person.middle_nm,
										int_person.last_nm
										FROM int_alarm
										INNER JOIN int_patient_monitor ON int_patient_monitor.patient_id = int_alarm.patient_id
										INNER JOIN int_monitor ON int_monitor.monitor_id = int_patient_monitor.monitor_id
										INNER JOIN int_person ON int_person.person_id = int_alarm.patient_id

								UNION

									SELECT
										AlarmId AS event_id,
										MonitorName AS monitor_name,
										FIRST_NAME AS first_nm,
										MIDDLE_NAME AS middle_nm,
										LAST_NAME AS last_nm
										FROM v_LimitAlarms
										INNER JOIN v_DeviceSessionAssignment ON v_DeviceSessionAssignment.DeviceSessionId = v_LimitAlarms.DeviceSessionId
										INNER JOIN v_PatientTopicSessions ON v_PatientTopicSessions.TopicSessionId = v_LimitAlarms.TopicSessionId
										INNER JOIN v_Patients ON v_Patients.PATIENT_ID = v_PatientTopicSessions.PatientId

								UNION

									SELECT
										AlarmId AS event_id,
										MonitorName AS monitor_name,
										FIRST_NAME AS first_nm,
										MIDDLE_NAME AS middle_nm,
										LAST_NAME AS last_nm
										FROM v_GeneralAlarms
										INNER JOIN v_DeviceSessionAssignment ON v_DeviceSessionAssignment.DeviceSessionId = v_GeneralAlarms.DeviceSessionId
										INNER JOIN v_PatientTopicSessions ON v_PatientTopicSessions.TopicSessionId = v_GeneralAlarms.TopicSessionId
										INNER JOIN v_Patients ON v_Patients.PATIENT_ID = v_PatientTopicSessions.PatientId
								) AS event_origin ON event_origin.event_id = int_event_log.event_id
    ORDER BY int_event_log.event_dt;
  END
