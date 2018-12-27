
--QueryAlarmTextAnd12SecWave--GetAlarmText And 12SecWave
CREATE PROCEDURE [dbo].[usp_CEI_GetAlarmTextAnd12SecWaveForm]
AS
BEGIN
    SET NOCOUNT ON;
        SELECT 
        int_alarm.alarm_id, 
        int_alarm.start_dt, 
        int_alarm.alarm_level, 
        int_alarm_retrieved.annotation, 
        w1.waveform_data AS waveform_data1,
        w2.waveform_data AS waveform_data2,
        CAST(224 AS SMALLINT) AS sample_rate,
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
        INNER JOIN int_alarm_waveform w1 
            ON int_alarm.alarm_id=w1.alarm_id
        INNER JOIN int_alarm_waveform w2 
            ON int_alarm.alarm_id=w2.alarm_id
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
        WHERE w2.retrieved=0 AND w1.seq_num = 1 AND w2.seq_num = 2
        AND int_mrn_map.merge_cd='C';
    SET NOCOUNT OFF;
END
