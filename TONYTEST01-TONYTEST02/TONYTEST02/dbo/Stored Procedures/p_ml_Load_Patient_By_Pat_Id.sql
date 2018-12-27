
CREATE PROCEDURE [dbo].[p_ml_Load_Patient_By_Pat_Id]
  (
  @patientID UNIQUEIDENTIFIER
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
           int_patient.bsa
    FROM   int_patient
           LEFT OUTER JOIN int_misc_code
             ON ( int_patient.gender_cid = int_misc_code.code_id )
           INNER JOIN int_mrn_map
             ON ( int_patient.patient_id = int_mrn_map.patient_id ) AND ( int_mrn_map.merge_cd = 'C' )
           INNER JOIN int_person
             ON ( int_patient.patient_id = int_person.person_id )
    WHERE  ( int_mrn_map.patient_id = @patientID )
  END


