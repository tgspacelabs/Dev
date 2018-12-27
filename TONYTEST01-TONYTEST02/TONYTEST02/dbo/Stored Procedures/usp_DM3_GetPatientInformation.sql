

CREATE PROCEDURE [dbo].[usp_DM3_GetPatientInformation]
  (
  @patientId NVARCHAR(50) = NULL,
  @OrgId     NVARCHAR(50) = NULL
  )
AS
  BEGIN
    SELECT int_patient.patient_id,
           int_person.last_nm,
           int_person.first_nm,
           int_person.middle_nm,
           int_mrn_map.mrn_xid,
           int_mrn_map.mrn_xid2,
           int_mrn_map.organization_id,
           int_patient.dob,
           int_patient.gender_cid,
           int_misc_code.code,
           int_patient.height,
           int_patient.weight,
           int_patient.bsa,
           int_mrn_map.adt_adm_sw
    FROM   int_patient
           INNER JOIN int_mrn_map
             ON int_patient.patient_id = int_mrn_map.patient_id
           INNER JOIN int_person
             ON int_patient.patient_id = int_person.person_id
           LEFT OUTER JOIN int_misc_code
             ON int_patient.gender_cid = int_misc_code.code_id
    WHERE  int_mrn_map.mrn_xid = @patientId AND int_mrn_map.organization_id = @OrgId AND int_mrn_map.merge_cd = 'C';
  END


