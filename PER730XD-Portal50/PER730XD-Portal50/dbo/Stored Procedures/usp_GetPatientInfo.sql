--in line queries to SPs/ICS Admin Component
CREATE PROCEDURE [dbo].[usp_GetPatientInfo]
  (
 @PatientID UNIQUEIDENTIFIER
  )
AS
  BEGIN
      SELECT 
      int_mrn_map.mrn_xid,
      int_mrn_map.mrn_xid2,
      int_person.last_nm,
      int_person.first_nm,
      int_person.middle_nm, 
      int_patient.dob,
      int_misc_code.short_dsc,
      int_patient.height,
      int_patient.weight,
      int_patient.bsa,
      org1.organization_cd + ' - ' + org2.organization_cd AS Unit, 
      int_encounter.rm, int_encounter.bed,
      int_encounter_map.encounter_xid
      FROM 
      int_encounter 
      LEFT OUTER JOIN int_organization AS org1 
                ON (int_encounter.organization_id = org1.organization_id) 
      LEFT OUTER JOIN dbo.int_patient_monitor INNER JOIN int_monitor 
                ON (dbo.int_patient_monitor.monitor_id = int_monitor.monitor_id)
                ON (int_encounter.encounter_id = dbo.int_patient_monitor.encounter_id)  AND (int_encounter.patient_id = dbo.int_patient_monitor.patient_id) 
      INNER JOIN int_encounter_map 
                ON (int_encounter.encounter_id = int_encounter_map.encounter_id)  INNER JOIN int_person 
                ON (int_encounter.patient_id = int_person.person_id)
      INNER JOIN int_patient 
                ON (int_person.person_id = int_patient.patient_id) INNER JOIN int_mrn_map 
                ON (int_patient.patient_id = int_mrn_map.patient_id)
      INNER JOIN dbo.int_organization AS org2 
                ON (int_encounter.unit_org_id = org2.organization_id) LEFT OUTER JOIN int_misc_code 
                ON int_patient.gender_cid = int_misc_code.code_id 
      WHERE 
      (int_mrn_map.merge_cd = 'C') AND int_mrn_map.patient_id = @PatientID
                                                        
 END
