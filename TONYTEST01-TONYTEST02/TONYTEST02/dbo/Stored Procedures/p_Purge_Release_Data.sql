
CREATE PROCEDURE [dbo].[p_Purge_Release_Data]
AS
  TRUNCATE TABLE hl7_in_qhist

  TRUNCATE TABLE hl7_in_queue

  TRUNCATE TABLE hl7_msg_ack

  TRUNCATE TABLE hl7_out_queue

  TRUNCATE TABLE int_autoupdate_log

  TRUNCATE TABLE int_broadcast_msg

  TRUNCATE TABLE int_client_map

  TRUNCATE TABLE int_loader_stats

  TRUNCATE TABLE int_mon_request

  TRUNCATE TABLE int_monitor

  TRUNCATE TABLE int_patient_monitor

  TRUNCATE TABLE int_msg_log


