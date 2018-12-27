
CREATE PROCEDURE [dbo].[p_Purge_All_Patient_Data]
AS
  TRUNCATE TABLE hl7_in_qhist

  TRUNCATE TABLE hl7_in_queue

  TRUNCATE TABLE hl7_msg_ack

  TRUNCATE TABLE hl7_out_queue

  TRUNCATE TABLE int_12lead_report_new

  TRUNCATE TABLE int_12lead_report_edit

  TRUNCATE TABLE int_account

  TRUNCATE TABLE int_address

  TRUNCATE TABLE int_alarm

  TRUNCATE TABLE int_alarm_retrieved

  TRUNCATE TABLE int_alarm_waveform

  TRUNCATE TABLE int_allergy

  TRUNCATE TABLE int_diagnosis

  TRUNCATE TABLE int_diagnosis_drg

  TRUNCATE TABLE int_diagnosis_hcp_int

  TRUNCATE TABLE int_encounter

  TRUNCATE TABLE int_encounter_map

  TRUNCATE TABLE int_encounter_tfr_history

  TRUNCATE TABLE int_encounter_to_hcp_int

  TRUNCATE TABLE int_event_log

  TRUNCATE TABLE int_external_organization

  TRUNCATE TABLE int_guarantor

  TRUNCATE TABLE int_hcp

  TRUNCATE TABLE int_hcp_contact

  TRUNCATE TABLE int_hcp_license

  TRUNCATE TABLE int_hcp_map

  TRUNCATE TABLE int_hcp_specialty

  TRUNCATE TABLE int_insurance_plan

  TRUNCATE TABLE int_insurance_policy

  TRUNCATE TABLE int_mrn_map

  TRUNCATE TABLE int_nok

  TRUNCATE TABLE int_order

  TRUNCATE TABLE int_order_line

  TRUNCATE TABLE int_order_map

  TRUNCATE TABLE int_outbound_queue

  TRUNCATE TABLE int_param_timetag

  TRUNCATE TABLE int_patient

  TRUNCATE TABLE int_patient_channel

  TRUNCATE TABLE int_patient_document

  TRUNCATE TABLE int_patient_image

  TRUNCATE TABLE int_patient_link

  TRUNCATE TABLE int_patient_list

  TRUNCATE TABLE int_patient_list_detail

  TRUNCATE TABLE int_patient_list_link

  TRUNCATE TABLE int_patient_monitor

  TRUNCATE TABLE int_patient_procedure

  TRUNCATE TABLE int_person

  TRUNCATE TABLE int_person_name

  TRUNCATE TABLE int_print_job

  TRUNCATE TABLE int_print_job_waveform

  TRUNCATE TABLE int_procedure

  TRUNCATE TABLE int_procedure_hcp_int

  TRUNCATE TABLE int_reference_range

  TRUNCATE TABLE int_result

  TRUNCATE TABLE int_specimen

  TRUNCATE TABLE int_specimen_group

  TRUNCATE TABLE int_telephone

  TRUNCATE TABLE int_tech_map

  TRUNCATE TABLE int_vital_live

  TRUNCATE TABLE int_waveform

  TRUNCATE TABLE int_waveform_live

  TRUNCATE TABLE mpi_decision_log

  TRUNCATE TABLE mpi_decision_field

  TRUNCATE TABLE mpi_decision_queue

  TRUNCATE TABLE mpi_patient_link

  TRUNCATE TABLE mpi_search_results

  TRUNCATE TABLE mpi_search_work


