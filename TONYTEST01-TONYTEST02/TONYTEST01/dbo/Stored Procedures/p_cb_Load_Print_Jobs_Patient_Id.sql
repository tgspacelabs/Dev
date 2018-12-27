
CREATE PROCEDURE [dbo].[p_cb_Load_Print_Jobs_Patient_Id]
  (
  @PatientId UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT PJ.print_job_id,
           PJ.page_number,
           PJ.patient_id,
           PJ.job_net_dt,
           PJ.descr,
           PJ.print_sw,
           PJ.printer_name,
           PJ.status_code,
           PJ.status_msg,
           MM.mrn_xid,
           PER.first_nm,
           PER.middle_nm,
           PER.last_nm,
           PER.suffix
    FROM   int_print_job PJ
           LEFT OUTER JOIN int_person PER
             ON ( PJ.patient_id = PER.person_id )
           LEFT OUTER JOIN int_mrn_map MM
             ON ( PJ.patient_id = MM.patient_id )
    WHERE  ( MM.merge_cd = 'C' ) AND ( PJ.patient_id = @PatientId ) AND page_number =
               ( SELECT Max( page_number )
                 FROM   int_print_job PJ2
                 WHERE  PJ2.print_job_id = PJ.print_job_id )
    ORDER  BY job_net_dt
  END

