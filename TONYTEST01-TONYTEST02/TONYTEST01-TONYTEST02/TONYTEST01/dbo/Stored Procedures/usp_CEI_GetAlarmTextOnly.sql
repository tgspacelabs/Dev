

--CEI Procedures
--QueryTextOnly--GetAlarmTextOnly

CREATE PROCEDURE usp_CEI_GetAlarmTextOnly
AS
Begin
	SET NOCOUNT ON;
		SELECT 
		int_alarm.alarm_id, 
		int_alarm.start_dt, 
		int_alarm.alarm_level, 
		int_alarm_retrieved.annotation,
		int_mrn_map.mrn_xid, 
		int_mrn_map.mrn_xid2,
		int_person.first_nm, 
		int_person.middle_nm, 
		int_person.last_nm,
		int_person.person_id, 
		int_organization.organization_cd, 
		int_monitor.node_id, 
		int_monitor.monitor_name
		FROM int_alarm 
		INNER JOIN int_alarm_retrieved 
			ON int_alarm.alarm_id=int_alarm_retrieved.alarm_id
		INNER JOIN int_mrn_map 
			ON int_alarm.patient_id=int_mrn_map.patient_id
		INNER JOIN int_person 
			ON int_alarm.patient_id = int_person.person_id
		INNER JOIN int_patient_monitor 
			ON int_alarm.patient_id = int_patient_monitor.patient_id and int_patient_monitor.active_sw = 1
		INNER JOIN int_monitor 
			ON int_patient_monitor.monitor_id = int_monitor.monitor_id
		INNER JOIN int_organization 
			ON int_monitor.unit_org_id = int_organization.organization_id
		WHERE int_alarm_retrieved.retrieved=0 and int_mrn_map.merge_cd='C'
	SET NOCOUNT OFF;
End
