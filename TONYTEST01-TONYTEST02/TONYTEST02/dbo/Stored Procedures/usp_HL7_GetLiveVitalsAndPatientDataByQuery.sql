
-- =============================================
-- Author:		Alexander B
-- Create date: 16-05-2014
-- Description:	Retrieves the vitals and other patient data of all the active patients to generate the Oru messages
-- =============================================
CREATE PROCEDURE [dbo].[usp_HL7_GetLiveVitalsAndPatientDataByQuery]
(
@QRYItem NVARCHAR(80),
@type INT = -1
)
AS
  BEGIN
DECLARE @patient_id UNIQUEIDENTIFIER

SET @patient_id = dbo.fn_HL7_GetPatientIdFromQueryItemType(@QRYItem, @type)
	  

--Person and Patient data for PID
SELECT DISTINCT
		Pat.dob AS DateOfBirth, 
		Pat.gender_cid AS GenderCd, 		 
		Pat.death_dt AS DeathDate, 
		person.first_nm AS FirstName, 
		person.middle_nm AS MiddleName, 
		person.last_nm AS LastName, 
		int_mrn_map.mrn_xid2 as AccountNumber,
		int_mrn_map.mrn_xid as MRN,
		int_mrn_map.patient_id as PATIENT_ID,
		int_patient_monitor.monitor_id as DeviceId
		FROM  int_patient AS Pat 
		INNER JOIN int_person AS person 
			ON Pat.patient_id = person.person_id AND Pat.patient_id = @patient_id
		INNER JOIN int_mrn_map 
			ON Pat.patient_id = int_mrn_map.patient_id
		INNER JOIN int_patient_monitor
			ON Pat.patient_id = int_patient_monitor.patient_id
		WHERE (int_mrn_map.merge_cd = 'C')
		UNION ALL
		SELECT
		NULL AS DateOfBirth, 
		NULL AS GenderCd, 		
		NULL AS DeathDate, 
		FIRST_NAME AS FirstName, 
		MIDDLE_NAME AS MiddleName, 
		LAST_NAME AS LastName, 
		ACCOUNT_ID as AccountNumber,
		MRN_ID as MRN,
		v_PatientSessions.PATIENT_ID,
		DeviceId
		FROM v_PatientSessions
		WHERE PATIENT_ID = @patient_id
		
		
--Get Order data
		SELECT TOP 1 
		OrderNumber.Value ORDER_ID, 
		send_app SENDING_APPLICATION, 
		cast(OrderStatus.Value AS INT) ORDER_STATUS, 
		cast(NULL AS DATETIME) ORDER_DATE_TIME,
		@patient_id AS PATIENT_ID
		FROM int_gateway,
		(SELECT value FROM ApplicationSettings where [key] = 'DefaultFillerOrderStatus') AS OrderStatus,
		(SELECT value FROM ApplicationSettings where [key] = 'DefaultFillerOrderNumber') AS OrderNumber

-- Get OBR
		SELECT DISTINCT
		OrderNumber.Value ORDER_ID, 
		send_app AS SENDING_APPLICATION, 
		cast(NULL AS DATETIME) ORDER_DATE_TIME
		FROM int_gateway,
		(SELECT value FROM ApplicationSettings where [key] = 'DefaultFillerOrderNumber') AS OrderNumber

---Patient visit/encounter information

			SELECT 
			enc.patient_type_cid PatientType, 
			enc.med_svc_cid HospService ,
			enc.patient_class_cid PatientClass , 
			enc.ambul_status_cid AmbulatorySts,
			enc.vip_sw VipIndic , 
			enc.discharge_dispo_cid DischDisposition, 
			enc.admit_dt AdmitDate , 
			enc.discharge_dt DischargeDt, 
			encmap.encounter_XId VisitNumber, 
			enc.patient_id AS PATIENT_ID,
			encmap.seq_no SeqNo,
			monitor.monitor_name NodeName,
			monitor.node_Id NodeId , 
			monitor.room Room, 
			monitor.bed_cd Bed,
			organization.organization_cd UnitName,
			patMon.monitor_id as DeviceId
			FROM int_encounter AS enc
			INNER JOIN int_encounter_map AS encmap
				ON enc.Encounter_Id= encmap.encounter_id
			INNER JOIN int_patient_monitor AS patMon 
				ON patMon.encounter_id=enc.encounter_id AND patMon.active_sw = 1
			INNER JOIN int_monitor AS monitor
				ON patMon.monitor_id=Monitor.monitor_id
			INNER JOIN int_organization AS organization
				ON organization.organization_id = monitor.unit_org_id					
			WHERE patMon.patient_id = @patient_id
			AND enc.discharge_dt IS NULL
			
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
				  ,[PATIENT_ID] = [v_PatientSessions].[PATIENT_ID]
				  ,[SeqNo] = CAST(NULL AS INT)
				  ,[NodeName] = [v_PatientSessions].[MONITOR_NAME]
				  ,[NodeId] = CAST(NULL AS NVARCHAR(15))
				  ,[Room] = [v_PatientSessions].[ROOM]
				  ,[Bed] = [v_PatientSessions].[BED]
				  ,[UnitName] = [v_PatientSessions].[UNIT_NAME]
				  ,[DeviceId] = [v_PatientSessions].DeviceId
			  FROM [dbo].[v_PatientSessions]
			  WHERE PATIENT_ID = @patient_id

			ORDER BY AdmitDate DESC

--Get vitals

--for ML patients (Legacy Tele)
	SELECT DISTINCT
           VL.patient_id PATID,
           VL.Monitor_Id MONITORID,
           VL.collect_dt COLLECTDATE,
           VL.vital_value VITALS,
           VL.vital_time VITALSTIME,
           MRNMAP.Organization_Id ORGID,
           MRNMAP.mrn_xid MRN
    FROM   int_vital_live_temp VL,
           int_mrn_map MRNMAP,
           int_patient_monitor PM
    WHERE  
    VL.patient_id = @patient_id
    AND VL.patient_id = MRNMAP.patient_id 
    AND merge_cd = 'C' 
    AND PM.patient_id = VL.Patient_ID 
    AND PM.monitor_id = VL.monitor_id 
    AND VL.createdDT = ( SELECT Max( createdDT )
                 FROM   int_vital_live_temp AS VL_SUBTAB
                 WHERE  
                 VL_SUBTAB.monitor_id = VL.monitor_id 
                 AND VL_SUBTAB.patient_id = VL.patient_id 
                 AND createdDT > ( GetDate( ) - 0.002 ))
	ORDER BY VL.patient_id


--for DL patients
SELECT --*
		VitalsAll.CodeId
		,VitalsAll.GdsCode AS Code
		,VitalsAll.[Description] as Descr
		,VitalsAll.Units
		,VitalsAll.Value AS ResultValue
		,'' AS ValueTypeCd
		,NULL AS ResultStatus
		,NULL AS Probability
		,NULL AS ReferenceRange
		,NULL AS AbnormalNatureCd
		,NULL AS AbnormalCd
		,dbo.fnUtcDateTimeToLocalTime(TimestampUTC) as ResultTime
		,PatientId AS PATIENT_ID
		FROM 
		(
			SELECT	ROW_NUMBER() OVER (PARTITION BY PatientId, GdsCode ORDER BY TimeStampUTC DESC) as ROW_NUMBER,
			livedata.FeedTypeId, livedata.TopicInstanceId, livedata.Name, livedata.Value, GdsCode, GdsCodeMap.CodeId, Units, TimestampUTC, PatientId, [Description]
			from livedata
			INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].TopicInstanceId = LiveData.TopicInstanceId AND [TopicSessions].EndTimeUTC IS NULL
			INNER JOIN GdsCodeMap on GdsCodeMap.FeedTypeId = LiveData.FeedTypeId and GdsCodeMap.Name = LiveData.Name
			INNER JOIN v_PatientTopicSessions on TopicSessions.Id = v_PatientTopicSessions.TopicSessionId
			WHERE PatientId = @patient_id
		) VitalsAll
		where VitalsAll.ROW_NUMBER = 1 and Units IS NOT NULL
  END

