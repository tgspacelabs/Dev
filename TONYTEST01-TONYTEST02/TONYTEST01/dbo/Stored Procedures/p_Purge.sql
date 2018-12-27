
CREATE PROCEDURE [dbo].[p_Purge]
  (
  @mrn CHAR (30)
  )
AS
  DECLARE
    @pat_id UNIQUEIDENTIFIER,
    @msg    VARCHAR (120)

  SELECT @pat_id = patient_id
  FROM   int_mrn_map
  WHERE  mrn_xid = @mrn

  IF ( @pat_id IS NULL )
    SELECT 'patient not found..'
  ELSE
    BEGIN
      SET @msg = 'Purging patient: MRN=' + @mrn

      SET @msg = @msg + '  Patient_id = '

      SET @msg = @msg + CONVERT ( VARCHAR(45), @pat_id )

      SELECT @msg

      DELETE FROM int_patient
      WHERE  patient_id = @pat_id

      DELETE FROM int_person_name
      WHERE  person_nm_id = @pat_id

      DELETE FROM int_person
      WHERE  person_id = @pat_id

      DELETE FROM int_encounter
      WHERE  patient_id = @pat_id

      DELETE FROM int_result
      WHERE  patient_id = @pat_id

      DELETE FROM int_mrn_map
      WHERE  patient_id = @pat_id

      DELETE FROM int_encounter_map
      WHERE  patient_id = @pat_id

      DELETE FROM int_order_map
      WHERE  patient_id = @pat_id

      DELETE FROM int_order_line
      WHERE  patient_id = @pat_id

      DELETE FROM int_order
      WHERE  patient_id = @pat_id
    END

