
CREATE PROCEDURE [dbo].[p_cb_Get_Encounter_Id]
  (
  @PatientID UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT int_encounter_map.encounter_id,
           code AS CLASS_CD,
           admit_dt,
           begin_dt,
           discharge_dt,
           int_encounter.status_cd
    FROM   int_encounter
           LEFT OUTER JOIN int_misc_code
             ON ( int_encounter.patient_class_cid = int_misc_code.code_id )
           INNER JOIN int_encounter_map
             ON ( int_encounter.encounter_id = int_encounter_map.encounter_id )
    WHERE  ( int_encounter_map.patient_id = @PatientID )
  END


