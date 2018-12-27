
CREATE PROCEDURE [dbo].[p_Pat_Summary]
  (
  @mrn CHAR(30)
  )
AS
  SET NOCOUNT ON

  DECLARE
    @pat_id UNIQUEIDENTIFIER,
    @msg    VARCHAR (120)

  SELECT @pat_id = patient_id
  FROM   int_mrn_map
  WHERE  mrn_xid = @mrn

  IF ( @pat_id IS NULL )
    SELECT 'Patient not found ....'
  ELSE
    BEGIN
      SELECT 'PATIENT    ',
             *
      FROM   int_patient
      WHERE  patient_id = @pat_id

      SELECT PATIENT_MON='PATIENT_MON',
             *
      FROM   int_patient_monitor
      WHERE  patient_id = @pat_id

      SELECT PERSON_NAME='PERSON_NAME',
             *
      FROM   int_person_name
      WHERE  person_nm_id = @pat_id

      SELECT PERSON='PERSON     ',
             *
      FROM   int_person
      WHERE  person_id = @pat_id

      SELECT MRN_MAP='MRN_MAP    ',
             *
      FROM   int_mrn_map
      WHERE  patient_id = @pat_id

      SELECT ENCOUNTER='ENCOUNTER  ',
             *
      FROM   int_encounter
      WHERE  patient_id = @pat_id

      SELECT ORDER_MAP='ORDER_MAP  ',
             *
      FROM   int_order_map
      WHERE  patient_id = @pat_id

      SELECT 'ORDER'='ORDER      ',
             *
      FROM   int_order
      WHERE  patient_id = @pat_id

      SELECT ORDER_LINE='ORDER_LINE ',
             *
      FROM   int_order_line
      WHERE  patient_id = @pat_id

      SET NOCOUNT OFF

      SELECT RESULT='RESULT     ',
             *
      FROM   int_result
      WHERE  patient_id = @pat_id
    END


