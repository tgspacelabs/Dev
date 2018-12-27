CREATE PROCEDURE [dbo].[usp_HL7_GetLiveVitalsAndPatientDataForOru]
AS
BEGIN
    IF (OBJECT_ID(N'tempdb..#SelectedPatients') IS NOT NULL)
        DROP TABLE [#SelectedPatients];

    CREATE TABLE [#SelectedPatients]
        ([PatientId] UNIQUEIDENTIFIER);

    DECLARE @LastRunDateTime DATETIME;
    DECLARE @FilterUV BIT;

    SELECT @LastRunDateTime = DATEADD(SECOND, -CAST([icv].[keyvalue] AS INT), GETDATE())
    FROM [dbo].[int_cfg_values] AS [icv]
    WHERE [icv].[keyname] = 'vitalsRefreshInterval';

    --Get all active patient Ids and their corresponding Monitor Ids
    INSERT INTO [#SelectedPatients] ([PatientId])
    SELECT [MAP].[patient_id] AS [PATIENTID]
    FROM [dbo].[int_mrn_map] AS [MAP]
        INNER JOIN [dbo].[int_patient_monitor] AS [PATMON]
            ON [PATMON].[patient_id] = [MAP].[patient_id]
        INNER JOIN [dbo].[int_monitor] AS [MONITOR]
            ON [MONITOR].[monitor_id] = [PATMON].[monitor_id]
        INNER JOIN [dbo].[int_product_access] AS [ACCESS]
            ON [ACCESS].[organization_id] = [MONITOR].[unit_org_id]
        INNER JOIN [dbo].[int_organization] AS [ORG]
            ON [ORG].[organization_id] = [MONITOR].[unit_org_id]
               AND [ORG].[outbound_interval] > 0
        INNER JOIN [dbo].[int_encounter] AS [ENC]
            ON [PATMON].[encounter_id] = [ENC].[encounter_id]
    WHERE [MAP].[merge_cd] = 'C'
          AND [ACCESS].[product_cd] = 'outHL7'
          AND [ORG].[category_cd] = 'D'
          AND ([ENC].[discharge_dt] IS NULL
               OR [ENC].[mod_dt] > @LastRunDateTime)

    UNION

    SELECT [DLPAT].[patient_id] AS [PATIENTID]
    FROM [dbo].[v_PatientSessions] AS [DLPAT]
        INNER JOIN [dbo].[int_product_access] AS [Access]
            ON [Access].[organization_id] = [DLPAT].[UNIT_ID]
        INNER JOIN [dbo].[int_organization] AS [ORG]
            ON [ORG].[organization_id] = [DLPAT].[UNIT_ID]
               AND [ORG].[outbound_interval] > 0
    WHERE [DLPAT].[STATUS] = 'A'
          AND [Access].[product_cd] = 'outHL7'
          AND [ORG].[category_cd] = 'D';

    --Person and Patient data for PID
    SELECT @FilterUV = CASE [icv].[keyvalue]
                           WHEN 'true'
                               THEN
                               1
                           ELSE
                               0
                       END
    FROM [dbo].[int_cfg_values] AS [icv]
    WHERE [icv].[keyname] = 'DoNotSendUV';

    SELECT
        [Pat].[dob] AS [DateOfBirth],
        [Pat].[gender_cid] AS [GenderCd],
        [Pat].[death_dt] AS [DeathDate],
        [person].[first_nm] AS [FirstName],
        [person].[middle_nm] AS [MiddleName],
        [person].[last_nm] AS [LastName],
        [imm].[mrn_xid2] AS [AccountNumber],
        [imm].[mrn_xid] AS [MRN],
        [imm].[patient_id] AS [patient_id]
    FROM [dbo].[int_patient] AS [Pat]
        INNER JOIN [dbo].[int_person] AS [person]
            ON [Pat].[patient_id] = [person].[person_id]
               AND [Pat].[patient_id] IN (SELECT [sp].[PatientId] FROM [#SelectedPatients] AS [sp])
        INNER JOIN [dbo].[int_mrn_map] AS [imm]
            ON [Pat].[patient_id] = [imm].[patient_id]
    WHERE [imm].[merge_cd] = 'C'
          AND ((@FilterUV = 1
                AND [imm].[mrn_xid] NOT LIKE N'UV_%')
               OR @FilterUV = 0);

    --Get Order data
    SELECT
        [OrderNumber].[Value] AS [ORDER_ID],
        CAST([OrderStatus].[Value] AS INT) AS [ORDER_STATUS],
        CAST(NULL AS DATETIME) AS [ORDER_DATE_TIME],
        [Patients].[PatientId] AS [patient_id]
    FROM (SELECT [PatientId] FROM [#SelectedPatients]) AS [Patients]
        CROSS JOIN (SELECT [as].[Value]
                    FROM [dbo].[ApplicationSettings] AS [as]
                    WHERE [as].[Key] = 'DefaultFillerOrderStatus') AS [OrderStatus]
        CROSS JOIN (SELECT [as2].[Value]
                    FROM [dbo].[ApplicationSettings] AS [as2]
                    WHERE [as2].[Key] = 'DefaultFillerOrderNumber') AS [OrderNumber];

    --Patient visit/encounter information
    SELECT DISTINCT
           [enc].[patient_type_cid] AS [PatientType],
           [enc].[med_svc_cid] AS [HospService],
           [enc].[patient_class_cid] AS [PatientClass],
           [enc].[ambul_status_cid] AS [AmbulatorySts],
           [enc].[vip_sw] AS [VipIndic],
           [enc].[discharge_dispo_cid] AS [DischDisposition],
           [enc].[admit_dt] AS [AdmitDate],
           [enc].[discharge_dt] AS [DischargeDt],
           [encmap].[encounter_xid] AS [VisitNumber],
           [enc].[patient_id] AS [patient_id],
           [encmap].[seq_no] AS [SeqNo],
           [monitor].[monitor_name] AS [NodeName],
           [monitor].[node_id] AS [NodeId],
           [monitor].[room] AS [Room],
           [monitor].[bed_cd] AS [Bed],
           [organization].[organization_cd] AS [UnitName],
           [monitor].[monitor_id] AS [DeviceId]
    FROM [dbo].[int_encounter] AS [enc]
        INNER JOIN [dbo].[int_encounter_map] AS [encmap]
            ON [enc].[encounter_id] = [encmap].[encounter_id]
        INNER JOIN [dbo].[int_patient_monitor] AS [patMon]
            ON [patMon].[encounter_id] = [enc].[encounter_id]
               AND ([patMon].[active_sw] = 1
                    OR [enc].[mod_dt] > @LastRunDateTime)
        INNER JOIN [dbo].[int_monitor] AS [monitor]
            ON [patMon].[monitor_id] = [monitor].[monitor_id]
        INNER JOIN [dbo].[int_organization] AS [organization]
            ON [organization].[organization_id] = [monitor].[unit_org_id]
    WHERE [patMon].[patient_id] IN (SELECT [PatientId] FROM [#SelectedPatients])

    UNION ALL

    SELECT DISTINCT
           CAST(NULL AS INT) AS [PatientType],
           CAST(NULL AS INT) AS [HospService],
           CAST(NULL AS INT) AS [PatientClass],
           CAST(NULL AS INT) AS [AmbulatorySts],
           CAST(NULL AS NCHAR(2)) AS [VipIndic],
           CAST(NULL AS INT) AS [DischDisposition],
           [AdmitDate].[LocalDateTime] AS [AdmitDate],
           [DischargeDt].[LocalDateTime] AS [DischargeDt],
           CAST(NULL AS NVARCHAR(40)) AS [VisitNumber],
           [vps].[patient_id] AS [patient_id],
           CAST(NULL AS INT) AS [SeqNo],
           [vps].[MONITOR_NAME] AS [NodeName],
           CAST(NULL AS NVARCHAR(15)) AS [NodeId],
           [vps].[ROOM] AS [Room],
           [vps].[BED] AS [Bed],
           [vps].[UNIT_NAME] AS [UnitName],
           [vps].[DeviceId] AS [DeviceId]
    FROM [dbo].[v_PatientSessions] AS [vps]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[ADMIT_TIME_UTC]) AS [AdmitDate]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[DISCHARGED_TIME_UTC]) AS [DischargeDt]
    WHERE [patient_id] IN (SELECT [sp].[PatientId] FROM [#SelectedPatients] AS [sp])
          AND [vps].[STATUS] = 'A'
    ORDER BY [AdmitDate] DESC;

    --Get vitals

    --for ML patients (Legacy Tele)
    SELECT DISTINCT
           [VL].[patient_id] AS [PATID],
           [VL].[monitor_id] AS [MONITORID],
           [VL].[collect_dt] AS [COLLECTDATE],
           [VL].[vital_value] AS [VITALS],
           [VL].[vital_time] AS [VITALSTIME],
           [MRNMAP].[organization_id] AS [ORGID],
           [MRNMAP].[mrn_xid] AS [MRN]
    FROM [dbo].[int_vital_live_temp] AS [VL]
        INNER JOIN [dbo].[int_mrn_map] AS [MRNMAP]
            ON [VL].[patient_id] = [MRNMAP].[patient_id]
        INNER JOIN [dbo].[int_patient_monitor] AS [PM]
            ON [VL].[patient_id] = [PM].[patient_id]
               AND [VL].[monitor_id] = [PM].[monitor_id]
    WHERE [VL].[patient_id] IN (SELECT [PatientId] FROM [#SelectedPatients])
          AND [MRNMAP].[merge_cd] = 'C'
          AND [VL].[collect_dt] = (SELECT MAX([VL_SUBTAB].[collect_dt])
                                   FROM [dbo].[int_vital_live_temp] AS [VL_SUBTAB]
                                   WHERE [VL_SUBTAB].[monitor_id] = [VL].[monitor_id]
                                         AND [VL_SUBTAB].[patient_id] = [VL].[patient_id]
                                         AND [VL_SUBTAB].[createdDT] > (GETDATE() - 0.002));

    --for DL patients
    SELECT
        [VitalsAll].[CodeId],
        [VitalsAll].[GdsCode] AS [Code],
        [VitalsAll].[Description] AS [Descr],
        [VitalsAll].[Units],
        [VitalsAll].[Value] AS [ResultValue],
        '' AS [ValueTypeCd],
        NULL AS [ResultStatus],
        NULL AS [Probability],
        NULL AS [ReferenceRange],
        NULL AS [AbnormalNatureCd],
        NULL AS [AbnormalCd],
        [ResultTime].[LocalDateTime] AS [ResultTime],
        [VitalsAll].[PatientId] AS [patient_id],
        [VitalsAll].[DeviceId]
    FROM (SELECT
              ROW_NUMBER() OVER (PARTITION BY
                                     [vpts].[PatientId],
                                     [gcm].[GdsCode]
                                 ORDER BY [ld].[TimestampUTC] DESC) AS [RowNumber],
              [ld].[FeedTypeId],
              [ld].[TopicInstanceId],
              [ld].[Name],
              [ld].[Value],
              [gcm].[GdsCode],
              [gcm].[CodeId],
              [gcm].[Units],
              [ld].[TimestampUTC],
              [vpts].[PatientId],
              [ts].[DeviceSessionId],
              [gcm].[Description],
              [ds].[DeviceId]
          FROM [dbo].[LiveData] AS [ld]
              INNER JOIN [dbo].[TopicSessions] AS [ts]
                  ON [ts].[TopicInstanceId] = [ld].[TopicInstanceId]
                     AND [ts].[EndTimeUTC] IS NULL
              INNER JOIN [dbo].[GdsCodeMap] AS [gcm]
                  ON [gcm].[FeedTypeId] = [ld].[FeedTypeId]
                     AND [gcm].[Name] = [ld].[Name]
              INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts]
                  ON [ts].[Id] = [vpts].[TopicSessionId]
              INNER JOIN [#SelectedPatients] AS [sp]
                  ON [vpts].[PatientId] = [sp].[PatientId]
              INNER JOIN [dbo].[DeviceSessions] AS [ds]
                  ON [ds].[Id] = [ts].[DeviceSessionId]
          WHERE [gcm].[Units] IS NOT NULL) AS [VitalsAll]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([VitalsAll].[TimestampUTC]) AS [ResultTime]
    WHERE [VitalsAll].[RowNumber] = 1;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieves the vitals and other patient data of all the active patients to generate the Oru messages', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_GetLiveVitalsAndPatientDataForOru';

