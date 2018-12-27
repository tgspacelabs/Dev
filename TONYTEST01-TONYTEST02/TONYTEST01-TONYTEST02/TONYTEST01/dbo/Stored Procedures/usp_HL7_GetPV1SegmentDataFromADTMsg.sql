
/*[usp_HL7_GetPV1SegmentDataFromADTMsg] get the  patient details by Account Number*/
CREATE PROCEDURE [dbo].[usp_HL7_GetPV1SegmentDataFromADTMsg](@patient_id2 UNIQUEIDENTIFIER)
AS
BEGIN
	SET NOCOUNT ON;
		SELECT 
		TOP 1 enc.patient_type_cid AS PatientType,
		enc.med_svc_cid AS HospService, 
		enc.patient_class_cid AS PatientClass, 
		enc.ambul_status_cid AS AmbulatorySts, 
		enc.vip_sw AS VipIndic, 
		enc.discharge_dispo_cid AS DischDisposition,
		enc.admit_dt AS AdmitDate, 
		enc.discharge_dt AS DischargeDt, 
		enc.status_cd, 
		int_encounter_map.encounter_xid AS VisitNumber
		FROM  
		int_encounter AS enc 
		INNER JOIN int_encounter_map 
			ON enc.encounter_id = int_encounter_map.encounter_id
		WHERE (enc.patient_id = @patient_id2) AND (enc.status_cd = 'C')
		AND enc.encounter_id NOT IN (SELECT encounter_id FROM int_patient_monitor WHERE active_sw=1)
		ORDER BY AdmitDate DESC
	SET NOCOUNT OFF;
END
