
CREATE PROCEDURE [dbo].[p_cb_Load_Patient]
  (
  @PatientId   VARCHAR(38),
  @EncounterId VARCHAR(38),
  @OwnerId     VARCHAR(38),
  @ListType    CHAR(20)
  )
AS
  BEGIN
    --- OwnerId <> '' & ListType <> 'UNIT'
    IF ( @OwnerId <> '' AND @ListType <> 'UNIT' )
      BEGIN
        SELECT int_person.person_id,
               int_person.last_nm,
               int_person.first_nm,
               int_person.middle_nm,
               int_person.suffix,
               int_patient.gender_cid,
               dob,
               O2.organization_cd AS DEPARTMENT_CD,
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
               int_hcp.last_nm AS HCP_LNAME,
               int_hcp.first_nm AS HCP_FNAME,
               int_patient.ssn,
               int_encounter_map.encounter_xid,
               new_results,
               viewed_results_dt,
               int_patient_list_detail.patient_list_id,
               int_encounter.organization_id
        FROM   int_encounter
               LEFT OUTER JOIN int_hcp
                 ON ( int_encounter.attend_hcp_id = int_hcp.hcp_id )
               LEFT OUTER JOIN int_organization O1
                 ON ( int_encounter.organization_id = O1.organization_id )
               LEFT OUTER JOIN int_organization O2
                 ON ( int_encounter.unit_org_id = O2.organization_id )
               INNER JOIN int_encounter_map
                 ON ( int_encounter.encounter_id = int_encounter_map.encounter_id )
               INNER JOIN int_patient_list_detail
                 ON ( int_encounter.encounter_id = int_patient_list_detail.encounter_id )
               INNER JOIN int_patient_list
                 ON ( int_patient_list_detail.patient_list_id = int_patient_list.patient_list_id )
               INNER JOIN int_person
                 ON ( int_patient_list_detail.patient_id = int_person.person_id )
               INNER JOIN int_patient
                 ON ( int_person.person_id = int_patient.patient_id )
               INNER JOIN int_mrn_map
                 ON ( int_person.person_id = int_mrn_map.patient_id )
        WHERE  ( int_encounter.encounter_id = @EncounterId ) AND ( int_mrn_map.merge_cd = 'C' ) AND ( int_person.person_id = @PatientId ) AND ( O2.organization_id = @OwnerId )

      END
    -- OWnerId <> '' ListType = 'UNIT'
    ELSE IF ( @OwnerId <> '' AND @ListType = 'UNIT' )
      BEGIN
        SELECT int_person.person_id,
               int_person.last_nm,
               int_person.first_nm,
               int_person.middle_nm,
               int_person.suffix,
               int_patient.gender_cid,
               dob,
               O2.organization_cd AS DEPARTMENT_CD,
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
               int_hcp.last_nm AS HCP_LNAME,
               int_hcp.first_nm AS HCP_FNAME,
               int_patient.ssn,
               int_encounter_map.encounter_xid,
               int_encounter.organization_id
        FROM   int_encounter
               LEFT OUTER JOIN int_hcp
                 ON ( int_encounter.attend_hcp_id = int_hcp.hcp_id )
               LEFT OUTER JOIN int_organization O2
                 ON ( int_encounter.unit_org_id = O2.organization_id )
               INNER JOIN int_encounter_map
                 ON ( int_encounter.encounter_id = int_encounter_map.encounter_id )
               INNER JOIN int_organization O1
                 ON ( int_encounter.organization_id = O1.organization_id ),
               int_person
               INNER JOIN int_patient
                 ON ( int_person.person_id = int_patient.patient_id )
               INNER JOIN int_mrn_map
                 ON ( int_person.person_id = int_mrn_map.patient_id )
        WHERE  ( int_encounter.encounter_id = @EncounterId ) AND ( int_mrn_map.merge_cd = 'C' ) AND ( int_person.person_id = @PatientId ) AND ( O2.organization_id = @OwnerId )
      END
    ELSE
      BEGIN
        -- OwnerId = ''
        SELECT int_person.person_id,
               int_person.last_nm,
               int_person.first_nm,
               int_person.middle_nm,
               int_person.suffix,
               int_patient.gender_cid,
               dob,
               O2.organization_cd AS DEPARTMENT_CD,
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
               int_hcp.last_nm AS HCP_LNAME,
               int_hcp.first_nm AS HCP_FNAME,
               int_patient.ssn,
               int_encounter_map.encounter_xid,
               int_encounter.organization_id
        FROM   int_encounter
               LEFT OUTER JOIN int_hcp
                 ON ( int_encounter.attend_hcp_id = int_hcp.hcp_id )
               LEFT OUTER JOIN int_organization O1
                 ON ( int_encounter.encounter_id = O1.organization_id )
               LEFT OUTER JOIN int_organization O2
                 ON ( int_encounter.unit_org_id = O2.organization_id )
               INNER JOIN int_encounter_map
                 ON ( int_encounter.encounter_id = int_encounter_map.encounter_id ),
               int_person
               INNER JOIN int_patient
                 ON ( int_person.person_id = int_patient.patient_id )
               INNER JOIN int_mrn_map
                 ON ( int_person.person_id = int_mrn_map.patient_id )
        WHERE  ( int_encounter.encounter_id = @EncounterId ) AND ( int_mrn_map.merge_cd = 'C' ) AND ( int_person.person_id = @PatientId )
      END
  END


