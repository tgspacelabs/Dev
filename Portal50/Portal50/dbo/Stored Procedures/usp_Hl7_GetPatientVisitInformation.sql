
/*[usp_Hl7_GetPV1SegmentData] used to get patient visit data
1)Query by Patient Id
2)Query by patient Id and Monitor Id*/
CREATE PROCEDURE [dbo].[usp_Hl7_GetPatientVisitInformation](@patient_id uniqueidentifier,@monitor_id MonitorIdTable READONLY)
AS
BEGIN
	SET NOCOUNT ON;
		IF((select COUNT(*) from @monitor_id) > 0 AND @patient_id IS NOT NULL)
		BEGIN
			SELECT
			TOP 1 enc.patient_type_cid PatientType, 
			enc.med_svc_cid HospService ,
			enc.patient_class_cid PatientClass , 
			enc.ambul_status_cid AmbulatorySts , 
			enc.vip_sw VipIndic , 
			enc.discharge_dispo_cid DischDisposition,
			enc.admit_dt AdmitDate , 
			enc.discharge_dt DischargeDt , 
			encmap.encounter_XId VisitNumber , 
			encmap.seq_no SeqNo, 
			monitor.monitor_name NodeName, 
			monitor.node_Id NodeId , 
			monitor.room Room, 
			monitor.bed_cd Bed, 
			organization.organization_cd UnitName
			FROM int_encounter AS enc
			INNER JOIN int_encounter_map AS encmap
				ON enc.Encounter_Id= encmap.encounter_id
			INNER JOIN int_patient_monitor AS patMon 
				ON patMon.encounter_id=enc.encounter_id AND patMon.active_sw = 1
			INNER JOIN int_monitor AS monitor
				ON patMon.monitor_id=Monitor.monitor_id 
			INNER JOIN int_organization AS organization
				ON organization.organization_id =monitor.unit_org_id 
			WHERE patMon.patient_id = @patient_id AND Monitor.monitor_id IN (select monitor_id from @monitor_Id)
					
					UNION ALL

			SELECT DISTINCT [PatientType] = CAST(NULL AS INT)
			      ,[HospService] = CAST(NULL AS INT)
				  ,[PatientClass] = CAST(NULL AS INT)
				  ,[AmbulatorySts] = CAST(NULL AS INT)
				  ,[VipIndic] = CAST(NULL AS NCHAR(2))
				  ,[DischDisposition] = CAST(NULL AS INT)
				  ,[AdmitDate] = [dbo].[fnUtcDateTimeToLocalTime]([v_PatientSessions].[ADMIT_TIME_UTC])
				  ,[DischargeDt] = [dbo].[fnUtcDateTimeToLocalTime]([v_PatientSessions].[DISCHARGED_TIME_UTC])
				  ,[VisitNumber] = CAST(NULL AS NVARCHAR(40))
				  ,[SeqNo] = CAST(NULL AS INT)
				  ,[NodeName] = [v_PatientSessions].[MONITOR_NAME]
				  ,[NodeId] = CAST(NULL AS NVARCHAR(15))
				  ,[Room] = [v_PatientSessions].[ROOM]
				  ,[Bed] = [v_PatientSessions].[BED]
				  ,[UnitName] = [v_PatientSessions].[UNIT_NAME]
			  FROM [dbo].[v_PatientSessions]
			  WHERE patient_id = @patient_id AND PATIENT_MONITOR_ID IN (select monitor_id from @monitor_Id)
			ORDER BY AdmitDate DESC
		END
		ELSE
		BEGIN
			SELECT 
			TOP 1 enc.patient_type_cid PatientType, 
			enc.med_svc_cid HospService ,
			enc.patient_class_cid PatientClass , 
			enc.ambul_status_cid AmbulatorySts,
			enc.vip_sw VipIndic , 
			enc.discharge_dispo_cid DischDisposition, 
			enc.admit_dt AdmitDate , 
			enc.discharge_dt DischargeDt, 
			encmap.encounter_XId VisitNumber , 
			encmap.seq_no SeqNo,
			monitor.monitor_name NodeName,
			monitor.node_Id NodeId , 
			monitor.room Room, 
			monitor.bed_cd Bed,
			organization.organization_cd UnitName 
			FROM int_encounter AS enc
			INNER JOIN int_encounter_map AS encmap
				ON enc.Encounter_Id= encmap.encounter_id
			INNER JOIN int_patient_monitor AS patMon 
				ON patMon.encounter_id=enc.encounter_id AND patMon.active_sw = 1
			INNER JOIN int_monitor AS monitor
				ON patMon.monitor_id=Monitor.monitor_id
			INNER JOIN int_organization AS organization
				ON organization.organization_id =monitor.unit_org_id 
			WHERE patMon.patient_id = @patient_id 
			
			UNION ALL
			
						SELECT DISTINCT [PatientType] = CAST(NULL AS INT)
			      ,[HospService] = CAST(NULL AS INT)
				  ,[PatientClass] = CAST(NULL AS INT)
				  ,[AmbulatorySts] = CAST(NULL AS INT)
				  ,[VipIndic] = CAST(NULL AS NCHAR(2))
				  ,[DischDisposition] = CAST(NULL AS INT)
				  ,[AdmitDate] = [dbo].[fnUtcDateTimeToLocalTime]([v_PatientSessions].[ADMIT_TIME_UTC])
				  ,[DischargeDt] = [dbo].[fnUtcDateTimeToLocalTime]([v_PatientSessions].[DISCHARGED_TIME_UTC])
				  ,[VisitNumber] = CAST(NULL AS NVARCHAR(40))
				  ,[SeqNo] = CAST(NULL AS INT)
				  ,[NodeName] = [v_PatientSessions].[MONITOR_NAME]
				  ,[NodeId] = CAST(NULL AS NVARCHAR(15))
				  ,[Room] = [v_PatientSessions].[ROOM]
				  ,[Bed] = [v_PatientSessions].[BED]
				  ,[UnitName] = [v_PatientSessions].[UNIT_NAME]
			  FROM [dbo].[v_PatientSessions]
			  WHERE patient_id = @patient_id
			  
			ORDER BY AdmitDate DESC
		END
	SET NOCOUNT OFF;
END
