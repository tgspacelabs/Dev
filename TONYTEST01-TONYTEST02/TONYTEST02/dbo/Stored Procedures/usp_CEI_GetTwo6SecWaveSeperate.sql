

--QueryTwo6SecWaveSeparate--usp_CEI_GetTwo6SecWaveSeperate

CREATE PROCEDURE [dbo].[usp_CEI_GetTwo6SecWaveSeperate]
AS
	BEGIN
	SET NOCOUNT ON;
		SELECT 
		int_alarm.alarm_id, 
		int_alarm.start_dt, 
		int_alarm.alarm_level, 
		int_alarm_retrieved.annotation, 
		int_alarm_waveform.waveform_data, 
		CAST(224 AS SMALLINT) AS sample_rate,
		int_alarm_waveform.seq_num, 
		int_mrn_map.mrn_xid,
		int_mrn_map.mrn_xid2,
		int_person.first_nm, 
		int_person.middle_nm, 
		int_person.last_nm,int_person.person_id, int_organization.organization_cd, 
		int_monitor.node_id, int_monitor.monitor_name
		FROM int_alarm 
		INNER JOIN int_alarm_retrieved 
			ON int_alarm.alarm_id=int_alarm_retrieved.alarm_id
		INNER JOIN int_alarm_waveform 
			on int_alarm.alarm_id=int_alarm_waveform.alarm_id
		INNER JOIN int_mrn_map 
			on int_alarm.patient_id=int_mrn_map.patient_id
		INNER JOIN int_person 
			on int_alarm.patient_id = int_person.person_id
		INNER JOIN int_patient_monitor 
			on int_alarm.patient_id = int_patient_monitor.patient_id and int_patient_monitor.active_sw = 1
		INNER JOIN int_monitor 
			on int_patient_monitor.monitor_id = int_monitor.monitor_id
		INNER JOIN int_organization 
			on int_monitor.unit_org_id = int_organization.organization_id
		where int_alarm_waveform.retrieved=0
		and int_mrn_map.merge_cd='C'
	SET NOCOUNT OFF;
END

