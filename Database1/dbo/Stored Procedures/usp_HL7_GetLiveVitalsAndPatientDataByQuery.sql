
-- Retrieves the vitals and other patient data of all the active patients to generate the Oru messages
CREATE PROCEDURE [dbo].[usp_HL7_GetLiveVitalsAndPatientDataByQuery]
    (
     @QRYItem NVARCHAR(80),
     @type INT = -1
    )
AS
BEGIN
    --SET NOCOUNT ON;

    DECLARE @patient_id UNIQUEIDENTIFIER;

    SET @patient_id = [dbo].[fn_HL7_GetPatientIdFromQueryItemType](@QRYItem, @type);

    --Person and Patient data for PID
    SELECT DISTINCT
        [Pat].[dob] AS [DateOfBirth],
        [Pat].[gender_cid] AS [GenderCd],
        [Pat].[death_dt] AS [DeathDate],
        [person].[first_nm] AS [FirstName],
        [person].[middle_nm] AS [MiddleName],
        [person].[last_nm] AS [LastName],
        [mrn_xid2] AS [AccountNumber],
        [mrn_xid] AS [MRN],
        [int_mrn_map].[patient_id] AS [PATIENT_ID],
        [monitor_id] AS [DeviceId]
    FROM
        [dbo].[int_patient] AS [Pat]
        INNER JOIN [dbo].[int_person] AS [person] ON [Pat].[patient_id] = [person].[person_id]
                                                     AND [Pat].[patient_id] = @patient_id
        INNER JOIN [dbo].[int_mrn_map] ON [Pat].[patient_id] = [int_mrn_map].[patient_id]
        INNER JOIN [dbo].[int_patient_monitor] ON [Pat].[patient_id] = [int_patient_monitor].[patient_id]
    WHERE
        ([merge_cd] = 'C')
    UNION ALL
    SELECT
        NULL AS [DateOfBirth],
        NULL AS [GenderCd],
        NULL AS [DeathDate],
        [FIRST_NAME] AS [FirstName],
        [MIDDLE_NAME] AS [MiddleName],
        [LAST_NAME] AS [LastName],
        [ACCOUNT_ID] AS [AccountNumber],
        [MRN_ID] AS [MRN],
        [PATIENT_ID],
        [DeviceId]
    FROM
        [dbo].[v_PatientSessions]
    WHERE
        [PATIENT_ID] = @patient_id;

    --Get Order data
    SELECT TOP 1
        [OrderNumber].[Value] [ORDER_ID],
        [send_app] [SENDING_APPLICATION],
        CAST([OrderStatus].[Value] AS INT) [ORDER_STATUS],
        CAST(NULL AS DATETIME) [ORDER_DATE_TIME],
        @patient_id AS [PATIENT_ID]
    FROM
        [dbo].[int_gateway],
        (SELECT
            [Value]
         FROM
            [dbo].[ApplicationSettings]
         WHERE
            [Key] = 'DefaultFillerOrderStatus'
        ) AS [OrderStatus],
        (SELECT
            [Value]
         FROM
            [dbo].[ApplicationSettings]
         WHERE
            [Key] = 'DefaultFillerOrderNumber'
        ) AS [OrderNumber];

    -- Get OBR
    SELECT DISTINCT
        [OrderNumber].[Value] [ORDER_ID],
        [send_app] AS [SENDING_APPLICATION],
        CAST(NULL AS DATETIME) [ORDER_DATE_TIME]
    FROM
        [dbo].[int_gateway],
        (SELECT
            [Value]
         FROM
            [dbo].[ApplicationSettings]
         WHERE
            [Key] = 'DefaultFillerOrderNumber'
        ) AS [OrderNumber];

    --Patient visit/encounter information
    SELECT
        [enc].[patient_type_cid] [PatientType],
        [enc].[med_svc_cid] [HospService],
        [enc].[patient_class_cid] [PatientClass],
        [enc].[ambul_status_cid] [AmbulatorySts],
        [enc].[vip_sw] [VipIndic],
        [enc].[discharge_dispo_cid] [DischDisposition],
        [enc].[admit_dt] [AdmitDate],
        [enc].[discharge_dt] [DischargeDt],
        [encmap].[encounter_xid] [VisitNumber],
        [enc].[patient_id] AS [PATIENT_ID],
        [encmap].[seq_no] [SeqNo],
        [monitor].[monitor_name] [NodeName],
        [monitor].[node_id] [NodeId],
        [monitor].[room] [Room],
        [monitor].[bed_cd] [Bed],
        [organization].[organization_cd] [UnitName],
        [patMon].[monitor_id] AS [DeviceId]
    FROM
        [dbo].[int_encounter] AS [enc]
        INNER JOIN [dbo].[int_encounter_map] AS [encmap] ON [enc].[encounter_id] = [encmap].[encounter_id]
        INNER JOIN [dbo].[int_patient_monitor] AS [patMon] ON [patMon].[encounter_id] = [enc].[encounter_id]
                                                              AND [patMon].[active_sw] = 1
        INNER JOIN [dbo].[int_monitor] AS [monitor] ON [patMon].[monitor_id] = [monitor].[monitor_id]
        INNER JOIN [dbo].[int_organization] AS [organization] ON [organization].[organization_id] = [monitor].[unit_org_id]
    WHERE
        [patMon].[patient_id] = @patient_id
        AND [enc].[discharge_dt] IS NULL
    UNION ALL
    SELECT DISTINCT
        [PatientType] = CAST(NULL AS INT),
        [HospService] = CAST(NULL AS INT),
        [PatientClass] = CAST(NULL AS INT),
        [AmbulatorySts] = CAST(NULL AS INT),
        [VipIndic] = CAST(NULL AS NCHAR(2)),
        [DischDisposition] = CAST(NULL AS INT),
        [AdmitDate] = [dbo].[fnUtcDateTimeToLocalTime]([ADMIT_TIME_UTC]),
        [DischargeDt] = [dbo].[fnUtcDateTimeToLocalTime]([DISCHARGED_TIME_UTC]),
        [VisitNumber] = CAST(NULL AS NVARCHAR(40)),
        [PATIENT_ID] = [PATIENT_ID],
        [SeqNo] = CAST(NULL AS INT),
        [NodeName] = [MONITOR_NAME],
        [NodeId] = CAST(NULL AS NVARCHAR(15)),
        [Room] = [ROOM],
        [Bed] = [BED],
        [UnitName] = [UNIT_NAME],
        [DeviceId] = [DeviceId]
    FROM
        [dbo].[v_PatientSessions]
    WHERE
        [PATIENT_ID] = @patient_id
    ORDER BY
        [AdmitDate] DESC;

    --Get vitals

    --for ML patients (Legacy Tele)
    SELECT DISTINCT
        [VL].[patient_id] [PATID],
        [VL].[monitor_id] [MONITORID],
        [VL].[collect_dt] [COLLECTDATE],
        [VL].[vital_value] [VITALS],
        [VL].[vital_time] [VITALSTIME],
        [MRNMAP].[organization_id] [ORGID],
        [MRNMAP].[mrn_xid] [MRN]
    FROM
        [dbo].[int_vital_live_temp] [VL],
        [dbo].[int_mrn_map] [MRNMAP],
        [dbo].[int_patient_monitor] [PM]
    WHERE
        [VL].[patient_id] = @patient_id
        AND [VL].[patient_id] = [MRNMAP].[patient_id]
        AND [MRNMAP].[merge_cd] = 'C'
        AND [PM].[patient_id] = [VL].[patient_id]
        AND [PM].[monitor_id] = [VL].[monitor_id]
        AND [VL].[createdDT] = (SELECT
                                    MAX([VL_SUBTAB].[createdDT])
                                FROM
                                    [dbo].[int_vital_live_temp] AS [VL_SUBTAB]
                                WHERE
                                    [VL_SUBTAB].[monitor_id] = [VL].[monitor_id]
                                    AND [VL_SUBTAB].[patient_id] = [VL].[patient_id]
                                    AND [VL_SUBTAB].[createdDT] > (GETDATE( ) - 0.002)
                               )
    ORDER BY
        [VL].[patient_id];

    -- For DL patients
    SELECT --*
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
        [dbo].[fnUtcDateTimeToLocalTime]([VitalsAll].[TimestampUTC]) AS [ResultTime],
        [VitalsAll].[PatientId] AS [PATIENT_ID]
    FROM
        (SELECT
            ROW_NUMBER() OVER (PARTITION BY [PatientId], [GdsCode] ORDER BY [TimestampUTC] DESC) AS [ROW_NUMBER],
            [LiveData].[FeedTypeId],
            [LiveData].[TopicInstanceId],
            [LiveData].[Name],
            [Value],
            [GdsCode],
            [CodeId],
            [Units],
            [TimestampUTC],
            [PatientId],
            [Description]
         FROM
            [dbo].[LiveData]
            INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[TopicInstanceId] = [LiveData].[TopicInstanceId]
                                                AND [EndTimeUTC] IS NULL
            INNER JOIN [dbo].[GdsCodeMap] ON [GdsCodeMap].[FeedTypeId] = [LiveData].[FeedTypeId]
                                             AND [GdsCodeMap].[Name] = [LiveData].[Name]
            INNER JOIN [dbo].[v_PatientTopicSessions] ON [TopicSessions].[Id] = [TopicSessionId]
         WHERE
            [PatientId] = @patient_id
        ) [VitalsAll]
    WHERE
        [VitalsAll].[ROW_NUMBER] = 1
        AND [VitalsAll].[Units] IS NOT NULL;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieves the vitals and other patient data of all the active patients to generate the Oru messages', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_GetLiveVitalsAndPatientDataByQuery';

