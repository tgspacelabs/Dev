
CREATE PROCEDURE [dbo].[p_cb_Load_Monitor_Patient_List]
AS
  BEGIN
    SELECT PR.person_id,
           PR.last_nm,
           PR.first_nm,
           PR.middle_nm,
           PR.suffix,
           PT.gender_cid,
           PT.dob,
           O2.organization_cd DEPARTMENT_CD,
           rm,
           bed,
           med_svc_cid,
           PM.*,
           mrn_xid,
           vip_sw,
           admit_dt,
           discharge_dt,
           begin_dt,
           E.encounter_id,
           E.status_cd,
           patient_class_cid,
           E.patient_type_cid,
           O1.organization_cd,
           O1.organization_nm,
           int_hcp.last_nm HCP_LNAME,
           int_hcp.first_nm HCP_FNAME,
           E.organization_id
    FROM   int_patient PT
           LEFT JOIN int_mrn_map M
             ON PT.patient_id = M.patient_id
           LEFT JOIN int_person PR
             ON PT.patient_id = PR.person_id
           LEFT JOIN int_encounter E
             ON PT.patient_id = E.patient_id
           LEFT JOIN int_hcp
             ON hcp_id = E.attend_hcp_id
           LEFT JOIN int_organization O1
             ON O1.organization_id = E.organization_id
           LEFT JOIN int_organization O2
             ON O2.organization_id = E.unit_org_id
           LEFT JOIN int_patient_monitor PM
             ON PM.encounter_id = E.encounter_id AND PM.patient_id = PT.patient_id
    WHERE  M.merge_cd = 'C' AND PM.active_sw = 1
  END


