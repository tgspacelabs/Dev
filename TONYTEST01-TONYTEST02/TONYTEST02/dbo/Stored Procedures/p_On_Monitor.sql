
CREATE PROCEDURE [dbo].[p_On_Monitor]
AS
  SELECT int_patient_monitor.patient_id,
         MRN=CONVERT ( CHAR(10), mrn_xid ),
         MONITOR=monitor_name,
         "LAST NAME"=CONVERT ( CHAR(15), last_nm ),
         "FIRST NAME"=CONVERT( CHAR(15), first_nm ),
         INTERVAL=monitor_interval,
         poll_start_dt,
         poll_end_dt,
         monitor_status,
         monitor_error
  FROM   int_mrn_map,
         int_person_name,
         int_patient_monitor,
         int_monitor
  WHERE  int_mrn_map.patient_id = int_person_name.person_nm_id AND int_patient_monitor.patient_id = int_mrn_map.patient_id AND int_patient_monitor.monitor_id = int_monitor.monitor_id


