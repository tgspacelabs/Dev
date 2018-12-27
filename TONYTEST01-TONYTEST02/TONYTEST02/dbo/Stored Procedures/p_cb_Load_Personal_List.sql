
CREATE PROCEDURE [dbo].[p_cb_Load_Personal_List]
  (
  @OwnerId UNIQUEIDENTIFIER,
  @UseMRE  CHAR
  )
AS
  BEGIN
    IF @UseMRE <> 'Y'
      BEGIN
        SELECT int_person.person_id,
               int_person.last_nm,
               int_person.first_nm,
               int_person.middle_nm,
               int_person.suffix,
               int_patient.gender_cid,
               int_patient.dob,
               O2.organization_cd DEPARTMENT_CD,
               int_encounter.rm,
               int_encounter.bed,
               int_encounter.med_svc_cid,
               mrn_xid,
               int_encounter.vip_sw,
               int_encounter.admit_dt,
               int_encounter.discharge_dt,
               int_encounter.begin_dt,
               int_encounter.encounter_id,
               int_encounter.status_cd,
               int_encounter.patient_class_cid,
               int_encounter.patient_type_cid,
               O1.organization_cd,
               O1.organization_nm,
               int_hcp.last_nm HCP_LNAME,
               int_hcp.first_nm HCP_FNAME,
               int_patient.ssn,
               int_encounter_map.encounter_xid,
               int_encounter.organization_id,
               int_patient_list_detail.patient_list_id,
               new_results,
               viewed_results_dt,
               int_patient_monitor.*
        FROM   int_patient_list_detail
               LEFT JOIN int_patient_list
                 ON int_patient_list.patient_list_id = int_patient_list_detail.patient_list_id
               LEFT JOIN int_encounter
                 ON int_encounter.encounter_id = int_patient_list_detail.encounter_id AND int_encounter.begin_dt =
                        ( SELECT Max( E3.begin_dt )
                          FROM   int_encounter E3
                          WHERE  E3.patient_id = int_encounter.patient_id )
               LEFT JOIN int_hcp
                 ON int_encounter.attend_hcp_id = int_hcp.hcp_id
               LEFT JOIN int_mrn_map
                 ON int_mrn_map.patient_id = int_patient_list_detail.patient_id AND int_mrn_map.merge_cd = 'C'
               LEFT JOIN int_organization O1
                 ON int_encounter.organization_id = O1.organization_id
               LEFT JOIN int_organization O2
                 ON int_encounter.unit_org_id = O2.organization_id
               LEFT JOIN int_person
                 ON int_patient_list_detail.patient_id = int_person.person_id
               LEFT JOIN int_encounter_map
                 ON int_encounter_map.encounter_id = int_encounter.encounter_id
               LEFT JOIN int_patient
                 ON int_patient.patient_id = int_person.person_id
               LEFT JOIN int_patient_monitor
                 ON int_encounter.encounter_id = int_patient_monitor.encounter_id AND int_encounter.patient_id = int_patient_monitor.patient_id
        WHERE  int_patient_list.owner_id = @OwnerId AND int_patient_list.type_cd = 'P'

      END
    ELSE
      BEGIN
        SELECT int_person.person_id,
               int_person.last_nm,
               int_person.first_nm,
               int_person.middle_nm,
               int_person.suffix,
               int_patient.gender_cid,
               int_patient.dob,
               O2.organization_cd DEPARTMENT_CD,
               int_encounter.rm,
               int_encounter.bed,
               int_encounter.med_svc_cid,
               mrn_xid,
               int_encounter.vip_sw,
               int_encounter.admit_dt,
               int_encounter.discharge_dt,
               int_encounter.begin_dt,
               int_encounter.encounter_id,
               int_encounter.status_cd,
               int_encounter.patient_class_cid,
               int_encounter.patient_type_cid,
               O1.organization_cd,
               O1.organization_nm,
               int_hcp.last_nm HCP_LNAME,
               int_hcp.first_nm HCP_FNAME,
               int_patient.ssn,
               int_encounter_map.encounter_xid,
               int_encounter.organization_id,
               int_patient_list_detail.patient_list_id,
               new_results,
               viewed_results_dt,
               int_patient_monitor.*
        FROM   int_patient_list_detail
               LEFT JOIN int_patient_list
                 ON int_patient_list.patient_list_id = int_patient_list_detail.patient_list_id
               LEFT JOIN int_encounter
                 ON int_encounter.encounter_id = int_patient_list_detail.encounter_id AND int_encounter.begin_dt =
                        ( SELECT Max( E3.begin_dt )
                          FROM   int_encounter E3
                          WHERE  E3.patient_id = int_encounter.patient_id )
               LEFT JOIN int_hcp
                 ON int_encounter.attend_hcp_id = int_hcp.hcp_id
               LEFT JOIN int_mrn_map
                 ON int_mrn_map.patient_id = int_patient_list_detail.patient_id AND int_mrn_map.merge_cd = 'C'
               LEFT JOIN int_organization O1
                 ON int_encounter.organization_id = O1.organization_id
               LEFT JOIN int_organization O2
                 ON int_encounter.unit_org_id = O2.organization_id
               LEFT JOIN int_person
                 ON int_patient_list_detail.patient_id = int_person.person_id
               LEFT JOIN int_encounter_map
                 ON int_encounter_map.encounter_id = int_encounter.encounter_id
               LEFT JOIN int_patient
                 ON int_patient.patient_id = int_person.person_id
               LEFT JOIN int_patient_monitor
                 ON int_encounter.encounter_id = int_patient_monitor.encounter_id AND int_encounter.patient_id = int_patient_monitor.patient_id
      END

  END


