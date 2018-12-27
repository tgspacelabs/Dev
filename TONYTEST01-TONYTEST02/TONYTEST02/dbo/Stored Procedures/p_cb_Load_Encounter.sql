
CREATE PROCEDURE [dbo].[p_cb_Load_Encounter]
  (
  @encounterID UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT int_encounter.encounter_id,
           int_encounter.organization_id,
           int_encounter.mod_dt,
           int_encounter.patient_id,
           int_encounter.orig_patient_id,
           int_encounter.account_id,
           int_encounter.publicity_cid,
           int_encounter.diet_type_cid,
           int_encounter.patient_class_cid,
           int_encounter.protection_type_cid,
           int_encounter.vip_sw,
           int_encounter.isolation_type_cid,
           int_encounter.security_type_cid,
           int_encounter.patient_type_cid,
           int_encounter.admit_hcp_id,
           int_encounter.med_svc_cid,
           int_encounter.referring_hcp_id,
           int_encounter.unit_org_id,
           int_encounter.attend_hcp_id,
           int_encounter.primary_care_hcp_id,
           int_encounter.fall_risk_type_cid,
           int_encounter.begin_dt,
           int_encounter.ambul_status_cid,
           int_encounter.admit_dt,
           int_encounter.baby_cd,
           int_encounter.rm,
           int_encounter.recurring_cd,
           int_encounter.bed,
           int_encounter.discharge_dt,
           int_encounter.newborn_sw,
           int_encounter.discharge_dispo_cid,
           int_encounter.monitor_created,
           int_encounter.comment,
           int_encounter_map.encounter_xid,
           int_encounter_map.organization_id,
           int_encounter_map.encounter_id,
           int_encounter_map.patient_id,
           int_encounter_map.seq_no,
           int_encounter_map.orig_patient_id,
           int_encounter_map.event_cd,
           int_encounter_map.account_id,
           int_hcp.hcp_id,
           int_hcp.hcp_type_cid,
           int_hcp.last_nm,
           int_hcp.first_nm,
           int_hcp.middle_nm,
           int_hcp.degree,
           int_hcp.verification_sw,
           int_hcp.doctor_ins_no_id,
           int_hcp.doctor_dea_no,
           int_hcp.medicare_id,
           int_hcp.medicaid_id,
           int_organization.organization_id,
           int_organization.category_cd,
           int_organization.parent_organization_id,
           int_organization.organization_cd,
           int_organization.organization_nm,
           int_organization.in_default_search,
           int_organization.monitor_disable_sw,
           int_organization.auto_collect_interval,
           int_organization.outbound_interval,
           int_organization.printer_name,
           int_organization.alarm_printer_name,
           int_encounter.status_cd AS ESC,
           int_encounter_map.status_cd AS EMSC,
           int_organization.organization_cd AS DEPARTMENT_CD
    FROM   int_encounter
           LEFT OUTER JOIN int_hcp
             ON ( int_encounter.attend_hcp_id = int_hcp.hcp_id )
           INNER JOIN int_encounter_map
             ON ( int_encounter.encounter_id = int_encounter_map.encounter_id )
           INNER JOIN int_organization
             ON ( int_encounter.unit_org_id = int_organization.organization_id )
    WHERE  ( int_encounter.encounter_id = @encounterID ) AND ( int_encounter_map.status_cd IN ( 'C', 'S' ) )
  END


