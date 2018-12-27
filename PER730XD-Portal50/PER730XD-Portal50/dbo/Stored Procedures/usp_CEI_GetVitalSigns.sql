--NewQueryVitalSigns--GetVitalSigns

CREATE PROCEDURE usp_CEI_GetVitalSigns
AS
BEGIN
    SET NOCOUNT ON;
        SELECT 
        int_vital_live.patient_id,
        int_vital_live.collect_dt, 
        int_vital_live.vital_value,  
        int_mrn_map.mrn_xid,
        int_mrn_map.mrn_xid2, 
        int_person.first_nm, 
        int_person.middle_nm,
        int_person.last_nm, 
        int_person.person_id,
        int_organization.organization_cd,
        int_monitor.node_id, 
        int_monitor.monitor_name
        FROM int_vital_live 
        INNER JOIN int_mrn_map 
            ON int_vital_live.patient_id=int_mrn_map.patient_id
        INNER JOIN int_person 
            ON int_vital_live.patient_id = int_person.person_id
        INNER JOIN int_monitor 
            ON int_vital_live.monitor_id = int_monitor.monitor_id
        INNER JOIN int_patient_monitor 
            ON int_vital_live.patient_id = int_patient_monitor.patient_id and int_patient_monitor.active_sw = 1 
        INNER JOIN int_organization 
            ON int_monitor.unit_org_id = int_organization.organization_id
        WHERE int_mrn_map.merge_cd='C';
    SET NOCOUNT OFF;
END
