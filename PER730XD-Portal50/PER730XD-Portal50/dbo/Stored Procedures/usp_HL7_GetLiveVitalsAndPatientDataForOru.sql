
-- =============================================
-- Author:        SyamB
-- Create date: 16-05-2014
-- Description:    Retrieves the vitals and other patient data of all the active patients to generate the Oru messages
-- =============================================
CREATE PROCEDURE [dbo].[usp_HL7_GetLiveVitalsAndPatientDataForOru]

AS
  BEGIN

DECLARE @SelectedPatients TABLE(PatientId UNIQUEIDENTIFIER)

DECLARE @LastRunDateTime DATETIME = DATEADD(s, -(SELECT CAST(keyValue AS INT) FROM int_cfg_values where keyname = 'vitalsRefreshInterval') , GETDATE())

--Get all active patient Ids and their corresponding Monitor Ids
INSERT INTO @SelectedPatients(PatientId)
    (SELECT map.patient_id AS PATIENTID
    FROM int_mrn_map MAP
    INNER JOIN int_patient_monitor AS PATMON ON PATMON.patient_id = MAP.patient_id
    INNER JOIN int_monitor AS MONITOR ON MONITOR.monitor_id = PATMON.monitor_id
    INNER JOIN int_product_access ACCESS  ON ACCESS.organization_id = MONITOR.unit_org_id
    INNER JOIN int_organization ORG ON ORG.organization_id = MONITOR.unit_org_id AND outbound_interval > 0
    INNER JOIN int_encounter ENC ON PATMON.encounter_id = ENC.encounter_id
    WHERE merge_cd = 'C'     
    AND Access.product_cd='outHL7' 
    AND Org.category_cd = 'D'
    AND ((ENC.discharge_dt IS NULL) 
         OR (ENC.mod_dt > @LastRunDateTime))
    UNION
    SELECT  DLPAT.PATIENT_ID AS PATIENTID
    FROM v_PatientSessions DLPAT
    INNER JOIN int_product_access Access  ON Access.organization_id = DLPAT.UNIT_ID
    INNER JOIN int_organization ORG ON ORG.organization_id = DLPAT.UNIT_ID AND outbound_interval > 0
    WHERE DLPAT.STATUS = 'A' 
    AND Access.product_cd='outHL7' 
    AND Org.category_cd = 'D')
            


--Person and Patient data for PID
DECLARE @FilterUV bit
SELECT @FilterUV = CASE keyvalue WHEN 'true' THEN 1 ELSE 0 END 
FROM dbo.int_cfg_values 
WHERE keyname = 'DoNotSendUV'

SELECT 
        Pat.dob AS DateOfBirth, 
        Pat.gender_cid AS GenderCd,          
        Pat.death_dt AS DeathDate, 
        person.first_nm AS FirstName, 
        person.middle_nm AS MiddleName, 
        person.last_nm AS LastName, 
        int_mrn_map.mrn_xid2 as AccountNumber,
        int_mrn_map.mrn_xid as MRN,
        int_mrn_map.patient_id as PATIENT_ID
        FROM  int_patient AS Pat 
        INNER JOIN int_person AS person 
            ON Pat.patient_id = person.person_id AND Pat.patient_id IN (SELECT PatientId FROM @SelectedPatients)
        INNER JOIN int_mrn_map 
            ON Pat.patient_id = int_mrn_map.patient_id
        WHERE (int_mrn_map.merge_cd = 'C')
        AND ((@FilterUV = 1 AND mrn_xid NOT LIKE 'UV_%')
        OR (@FilterUV = 0))
            
--Get Order data
        SELECT
        OrderNumber.Value ORDER_ID, 
        cast(OrderStatus.Value AS INT) ORDER_STATUS, 
        cast(NULL AS DATETIME) ORDER_DATE_TIME,
        Patients.PatientId AS PATIENT_ID
        FROM (SELECT PatientId FROM @SelectedPatients) AS Patients,
        (SELECT value FROM ApplicationSettings where [key] = 'DefaultFillerOrderStatus') AS OrderStatus,
        (SELECT value FROM ApplicationSettings where [key] = 'DefaultFillerOrderNumber') AS OrderNumber

---Patient visit/encounter information

            SELECT DISTINCT
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
            organization.organization_cd UnitName ,
            monitor.monitor_id AS [DeviceId]
            FROM int_encounter AS enc
            INNER JOIN int_encounter_map AS encmap
                ON enc.Encounter_Id= encmap.encounter_id
            INNER JOIN int_patient_monitor AS patMon 
                ON patMon.encounter_id=enc.encounter_id 
                    AND ((patMon.active_sw = 1) OR (enc.mod_dt > @LastRunDateTime))
            INNER JOIN int_monitor AS monitor
                ON patMon.monitor_id=Monitor.monitor_id
            INNER JOIN int_organization AS organization
                ON organization.organization_id = monitor.unit_org_id                    
            WHERE patMon.patient_id IN (SELECT PatientId FROM @SelectedPatients)

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
                  ,[DeviceId] = [v_patientSessions].[DeviceId]
              FROM [dbo].[v_PatientSessions]
              WHERE PATIENT_ID IN (SELECT PatientId FROM @SelectedPatients)

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
    VL.patient_id IN (SELECT PatientId FROM @SelectedPatients) 
    AND VL.patient_id = MRNMAP.patient_id 
    AND merge_cd = 'C' 
    AND PM.patient_id = VL.Patient_ID 
    AND PM.monitor_id = VL.monitor_id 
    AND VL.collect_dt = ( SELECT Max( collect_dt )
                 FROM   int_vital_live_temp AS VL_SUBTAB
                 WHERE  
                 VL_SUBTAB.monitor_id = VL.monitor_id 
                 AND VL_SUBTAB.patient_id = VL.patient_id 
                 AND createdDT > ( GetDate( ) - 0.002 ))


--for DL patients
    SELECT         
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
        ,DeviceSessions.DeviceId
        FROM 
        (
            SELECT    ROW_NUMBER() OVER (PARTITION BY PatientId, GdsCode ORDER BY TimeStampUTC DESC) as ROW_NUMBER,
            livedata.FeedTypeId, livedata.TopicInstanceId, livedata.Name, livedata.Value, GdsCode, GdsCodeMap.CodeId, Units, TimestampUTC, PatientId, DeviceSessionId, [Description]
            from livedata
            INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].TopicInstanceId = LiveData.TopicInstanceId AND [TopicSessions].EndTimeUTC IS NULL
            INNER JOIN GdsCodeMap on GdsCodeMap.FeedTypeId = LiveData.FeedTypeId and GdsCodeMap.Name = LiveData.Name
            INNER JOIN v_PatientTopicSessions on TopicSessions.Id = v_PatientTopicSessions.TopicSessionId
            WHERE PatientId IN (SELECT PatientId FROM @SelectedPatients)
        ) VitalsAll
        INNER JOIN DeviceSessions on DeviceSessions.Id = VitalsAll.DeviceSessionId
        where VitalsAll.ROW_NUMBER = 1 and Units IS NOT NULL

      END
