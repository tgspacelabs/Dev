
CREATE PROCEDURE [dbo].[p_rel_CleanUp]
AS
  TRUNCATE TABLE int_patient_monitor

  TRUNCATE TABLE int_mon_request

  TRUNCATE TABLE int_monitor

  TRUNCATE TABLE hl7_in_qhist

  TRUNCATE TABLE hl7_in_queue

  TRUNCATE TABLE hl7_msg_ack

  TRUNCATE TABLE hl7_out_queue

  TRUNCATE TABLE int_audit_log

  TRUNCATE TABLE int_autoupdate_log

  TRUNCATE TABLE int_broadcast_msg

  TRUNCATE TABLE int_client_map

  TRUNCATE TABLE int_loader_stats

  TRUNCATE TABLE int_msg_log

  TRUNCATE TABLE int_outbound_queue

  TRUNCATE TABLE mpi_decision_log

  TRUNCATE TABLE mpi_decision_queue

  TRUNCATE TABLE mpi_patient_link

  TRUNCATE TABLE mpi_search_work

  TRUNCATE TABLE int_environment

  TRUNCATE TABLE int_pref_diff

  TRUNCATE TABLE int_security_diff

  TRUNCATE TABLE int_result_flag

  TRUNCATE TABLE int_org_shift_sched

  TRUNCATE TABLE int_translate_list

  TRUNCATE TABLE int_user_group

  TRUNCATE TABLE int_user_password


