
CREATE PROCEDURE [dbo].[p_cb_Load_Unit_List]
  (
  @UnitId            CHAR(40),
  @Filter            INT,
  @ShowADTEncounters CHAR
  )
AS
  BEGIN
    DECLARE @Query VARCHAR(8000)

    SET @Query = 'SELECT int_person.person_id,
          int_person.last_nm,
          int_person.first_nm,
          int_person.middle_nm,
          int_person.suffix,
          int_patient.gender_cid,
          int_patient.dob,
          int_encounter.rm,
          int_encounter.bed,
          int_encounter.med_svc_cid,
          int_encounter.vip_sw,
          int_encounter.admit_dt,
          int_encounter.begin_dt,
          int_encounter.encounter_id,
          int_encounter.status_cd,
          int_encounter.patient_class_cid,
          int_encounter.patient_type_cid,
          int_encounter.discharge_dt,
          dbo.int_patient_monitor.patient_monitor_id,
          dbo.int_patient_monitor.patient_id,
          dbo.int_patient_monitor.orig_patient_id,
          dbo.int_patient_monitor.monitor_id,
          dbo.int_patient_monitor.monitor_interval,
          dbo.int_patient_monitor.poll_type,
          dbo.int_patient_monitor.monitor_connect_dt,
          dbo.int_patient_monitor.monitor_connect_num,
          dbo.int_patient_monitor.disable_sw,
          dbo.int_patient_monitor.last_poll_dt,
          dbo.int_patient_monitor.last_result_dt,
          dbo.int_patient_monitor.last_episodic_dt,
          dbo.int_patient_monitor.poll_start_dt,
          dbo.int_patient_monitor.poll_end_dt,
          dbo.int_patient_monitor.last_outbound_dt,
          dbo.int_patient_monitor.monitor_status,
          dbo.int_patient_monitor.monitor_error,
          dbo.int_patient_monitor.encounter_id,
          dbo.int_patient_monitor.live_until_dt,
          dbo.int_patient_monitor.active_sw,
          dbo.int_hcp.last_nm AS hcp_lname,
          dbo.int_hcp.first_nm AS hcp_fname,
          int_mrn_map.mrn_xid,
          o2.organization_cd AS department_cd,
          o1.organization_cd,
          o1.organization_nm,
          dbo.int_hcp.hcp_id,
          dbo.int_hcp.hcp_type_cid,
          dbo.int_hcp.middle_nm,
          dbo.int_hcp.degree,
          dbo.int_hcp.verification_sw,
          dbo.int_hcp.doctor_ins_no_id,
          dbo.int_hcp.doctor_dea_no,
          dbo.int_hcp.medicare_id,
          dbo.int_hcp.medicaid_id
   FROM dbo.int_hcp
        RIGHT OUTER JOIN int_encounter ON (dbo.int_hcp.hcp_id =
        int_encounter.attend_hcp_id)
        LEFT OUTER JOIN int_organization o1 ON (int_encounter.organization_id = o1.organization_id)
        LEFT OUTER JOIN dbo.int_patient_monitor ON (int_encounter.encounter_id = dbo.int_patient_monitor.encounter_id) AND
                                                   (int_encounter.patient_id = dbo.int_patient_monitor.patient_id)
        INNER JOIN int_person ON (int_encounter.patient_id = int_person.person_id)
        INNER JOIN int_patient ON (int_person.person_id = int_patient.patient_id)
        INNER JOIN int_mrn_map ON (int_patient.patient_id = int_mrn_map.patient_id)
        INNER JOIN int_organization o2 ON (int_encounter.unit_org_id = o2.organization_id)
   WHERE
     (int_mrn_map.merge_cd = ''C'')'

    IF @ShowAdtEncounters = 'N'
      BEGIN
        SET @Query = @Query + ' AND (dbo.int_patient_monitor.patient_monitor_id  is not null) '
      END

    SET @Query = @Query + ' AND (int_encounter.unit_org_id  = ''' + @UnitId + ''') '

    IF @Filter = 0
      BEGIN
        SET @Query = @Query + ' and int_encounter.discharge_dt is null'

        IF @ShowAdtEncounters = 'N'
          SET @Query = @Query + ' and int_encounter.monitor_created = 1 and int_patient_monitor.active_sw = 1'
        ELSE
          SET @Query = @Query + ' and ((ISNULL(int_patient_monitor.active_sw, 2) =2 and ISNULL(int_encounter.monitor_created, 2) = 2) or (int_patient_monitor.active_sw = 1))'
      END
    ELSE
      SET @Query = @Query + ' and (int_encounter.discharge_dt is null or
                           (DATEDIFF(hour, int_encounter.discharge_dt, GETDATE())) <= (' + Cast( @Filter AS CHAR ) + ' * 24))'

    IF @ShowAdtEncounters = 'N'
      SET @Query = @Query + ' and int_encounter.monitor_created = 1'

    EXEC(@Query)
  END


