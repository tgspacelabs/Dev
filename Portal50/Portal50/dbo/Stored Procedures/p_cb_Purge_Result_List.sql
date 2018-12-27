
CREATE PROCEDURE [dbo].[p_cb_Purge_Result_List]
  (
  @BeginDischargeDt VARCHAR(20),
  @EndDischargeDt   VARCHAR(20)
  )
AS
  BEGIN
    DECLARE @Query VARCHAR(8000)

    SET @Query = 'SELECT
                    int_person.person_id,
                    int_person.last_nm,
                    int_person.first_nm,
                    int_person.middle_nm,
                    int_person.suffix,
                    int_patient.gender_cid,
                    int_patient.dob,
                    o2.organization_cd department_cd,
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
                    o1.organization_cd,
                    o1.organization_nm,
                    int_hcp.last_nm  hcp_lname,
                    int_hcp.first_nm  hcp_fname,
                    int_patient.ssn,
                    int_encounter_map.encounter_xid,
                    int_encounter.organization_id,
                    NULL,
                    NULL,
                    NULL,
                    0 trans
                  FROM
                    int_encounter
                    LEFT OUTER JOIN int_hcp ON (int_encounter.attend_hcp_id = int_hcp.hcp_id)
                    LEFT OUTER JOIN int_organization o1 ON (int_encounter.organization_id = o1.organization_id)
                    INNER JOIN int_organization o2 ON (int_encounter.unit_org_id = o2.organization_id)
                    INNER JOIN int_encounter_map ON (int_encounter.encounter_id = int_encounter_map.encounter_id)
                    INNER JOIN int_patient ON (int_encounter_map.patient_id = int_patient.patient_id)
                    INNER JOIN int_mrn_map ON (int_patient.patient_id = int_mrn_map.patient_id)
                    INNER JOIN int_person ON (int_patient.patient_id = int_person.person_id)
                  WHERE
                    (int_mrn_map.merge_cd = ''C'')'

    IF ( @BeginDischargeDt <> ''  OR @BeginDischargeDt IS NOT NULL )
      SET @Query = @Query + ' and discharge_dt >= ''' + @BeginDischargeDt + '''';

    IF ( @EndDischargeDt <> ''  OR @EndDischargeDt IS NOT NULL )
      SET @Query = @Query + ' and discharge_dt <= ''' + @EndDischargeDt + '''';

    EXEC(@Query)
  END

