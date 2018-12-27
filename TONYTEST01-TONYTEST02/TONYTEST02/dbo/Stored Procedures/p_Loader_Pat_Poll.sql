
CREATE PROCEDURE [dbo].[p_Loader_Pat_Poll]
  (
  @org_id     UNIQUEIDENTIFIER,
  @network_id VARCHAR (50)
  )
AS
  SELECT MM.mrn_xid,
         MM.mrn_xid2,
         PAT.patient_id,
         PAT.dob,
         PAT.gender_cid,
         PAT.height,
         PAT.weight,
         PAT.bsa,
         PER.last_nm,
         PER.first_nm,
         PER.middle_nm,
         PM.patient_monitor_id,
         PM.monitor_interval,
         PM.monitor_connect_dt,
         PM.last_poll_dt,
         PM.last_result_dt,
         PM.last_episodic_dt,
         PM.poll_start_dt,
         PM.poll_end_dt,
         PM.monitor_status,
         PM.monitor_error,
         PM.encounter_id,
         PM.live_until_dt,
         MON.network_id,
         MON.monitor_id,
         MON.monitor_name,
         MON.node_id,
         MON.bed_id,
         MON.room,
         MON.monitor_type_cd,
         MON.unit_org_id,
         ORG.outbound_interval,
         ORG.organization_cd
  FROM   int_mrn_map MM,
         int_patient PAT,
         int_person PER,
         int_patient_monitor PM,
         int_monitor MON,
         int_encounter ENC,
         int_organization ORG
  WHERE  MM.patient_id = PAT.patient_id AND MM.merge_cd = 'C' AND PAT.patient_id = PER.person_id AND PAT.patient_id = PM.patient_id AND PM.monitor_id = MON.monitor_id AND PM.encounter_id = ENC.encounter_id AND ENC.discharge_dt IS NULL AND MON.unit_org_id = ORG.organization_id AND MM.organization_id = @org_id AND MON.network_id = @network_id AND PM.active_sw = 1


