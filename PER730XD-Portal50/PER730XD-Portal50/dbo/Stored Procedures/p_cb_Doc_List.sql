
CREATE PROCEDURE [dbo].[p_cb_Doc_List]
  (
  @HCPId UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT int_person.person_id,
           int_person.last_nm,
           int_person.first_nm,
           int_person.middle_nm,
           int_person.suffix,
           int_patient.gender_cid,
           int_patient.dob,
           O2.organization_cd DEPARTMENT_CD,
           rm,
           bed,
           med_svc_cid,
           mrn_xid,
           vip_sw,
           admit_dt,
           discharge_dt,
           begin_dt,
           int_encounter.encounter_id,
           int_encounter.status_cd,
           patient_class_cid,
           int_encounter.patient_type_cid,
           O1.organization_cd,
           O1.organization_nm,
           int_hcp.last_nm HCP_LNAME,
           int_hcp.first_nm HCP_FNAME,
           int_encounter.organization_id,
           int_patient_list_detail.patient_list_id,
           new_results,
           viewed_results_dt,
           0 TRANS,
           int_patient_monitor.*
    FROM   int_encounter
           LEFT OUTER JOIN int_hcp
             ON ( int_encounter.attend_hcp_id = int_hcp.hcp_id )
           LEFT OUTER JOIN int_organization O1
             ON ( int_encounter.organization_id = O1.organization_id )
           LEFT OUTER JOIN int_organization O2
             ON ( int_encounter.unit_org_id = O2.organization_id )
           LEFT OUTER JOIN int_patient_monitor
             ON ( int_encounter.encounter_id = int_patient_monitor.encounter_id ) AND ( int_encounter.patient_id = int_patient_monitor.patient_id )
           INNER JOIN int_patient_list_detail
             ON ( int_encounter.encounter_id = int_patient_list_detail.encounter_id )
           INNER JOIN int_mrn_map
             ON ( int_patient_list_detail.patient_id = int_mrn_map.patient_id )
           INNER JOIN int_person
             ON ( int_patient_list_detail.patient_id = int_person.person_id )
           INNER JOIN int_patient
             ON ( int_person.person_id = int_patient.patient_id )
           INNER JOIN int_patient_list
             ON ( int_patient_list.patient_list_id = int_patient_list_detail.patient_list_id )
    WHERE  ( int_patient_list.owner_id = @HCPId ) AND ( int_patient_list.owner_id IS NOT NULL ) AND ( int_patient_list.type_cd <> 'P' ) AND ( int_mrn_map.merge_cd = 'C' ) AND ( int_patient_list_detail.deleted = 0 )
  END

