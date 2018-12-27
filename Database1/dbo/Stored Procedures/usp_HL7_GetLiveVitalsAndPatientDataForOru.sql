
-- Retrieves the vitals and other patient data of all the active patients to generate the Oru messages
CREATE PROCEDURE [dbo].[usp_HL7_GetLiveVitalsAndPatientDataForOru]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SelectedPatients TABLE
        (
         [PatientId] UNIQUEIDENTIFIER
        );

    DECLARE @LastRunDateTime DATETIME = DATEADD(s, -(SELECT
                                                        CAST([keyvalue] AS INT)
                                                     FROM
                                                        [dbo].[int_cfg_values]
                                                     WHERE
                                                        [keyname] = 'vitalsRefreshInterval'
                                                    ), GETDATE());

    --Get all active patient Ids and their corresponding Monitor Ids
    INSERT  INTO @SelectedPatients
            ([PatientId]
            )
    (SELECT
        [MAP].[patient_id] AS [PATIENTID]
     FROM
        [dbo].[int_mrn_map] [MAP]
        INNER JOIN [dbo].[int_patient_monitor] AS [PATMON] ON [PATMON].[patient_id] = [MAP].[patient_id]
        INNER JOIN [dbo].[int_monitor] AS [MONITOR] ON [MONITOR].[monitor_id] = [PATMON].[monitor_id]
        INNER JOIN [dbo].[int_product_access] [ACCESS] ON [ACCESS].[organization_id] = [MONITOR].[unit_org_id]
        INNER JOIN [dbo].[int_organization] [ORG] ON [ORG].[organization_id] = [MONITOR].[unit_org_id]
                                                     AND [ORG].[outbound_interval] > 0
        INNER JOIN [dbo].[int_encounter] [ENC] ON [PATMON].[encounter_id] = [ENC].[encounter_id]
     WHERE
        [MAP].[merge_cd] = 'C'
        AND [ACCESS].[product_cd] = 'outHL7'
        AND [ORG].[category_cd] = 'D'
        AND (([ENC].[discharge_dt] IS NULL)
        OR ([ENC].[mod_dt] > @LastRunDateTime)
        )
     UNION
     SELECT
        [DLPAT].[PATIENT_ID] AS [PATIENTID]
     FROM
        [dbo].[v_PatientSessions] [DLPAT]
        INNER JOIN [dbo].[int_product_access] [Access] ON [Access].[organization_id] = [DLPAT].[UNIT_ID]
        INNER JOIN [dbo].[int_organization] [ORG] ON [ORG].[organization_id] = [DLPAT].[UNIT_ID]
                                                     AND [ORG].[outbound_interval] > 0
     WHERE
        [DLPAT].[STATUS] = 'A'
        AND [Access].[product_cd] = 'outHL7'
        AND [ORG].[category_cd] = 'D'
    );

    --Person and Patient data for PID
    DECLARE @FilterUV BIT;
    SELECT
        @FilterUV = CASE [keyvalue]
                      WHEN 'true' THEN 1
                      ELSE 0
                    END
    FROM
        [dbo].[int_cfg_values]
    WHERE
        [keyname] = 'DoNotSendUV';

    SELECT
        [Pat].[dob] AS [DateOfBirth],
        [Pat].[gender_cid] AS [GenderCd],
        [Pat].[death_dt] AS [DeathDate],
        [person].[first_nm] AS [FirstName],
        [person].[middle_nm] AS [MiddleName],
        [person].[last_nm] AS [LastName],
        [mrn_xid2] AS [AccountNumber],
        [mrn_xid] AS [MRN],
        [int_mrn_map].[patient_id] AS [PATIENT_ID]
    FROM
        [dbo].[int_patient] AS [Pat]
        INNER JOIN [dbo].[int_person] AS [person] ON [Pat].[patient_id] = [person].[person_id]
                                                     AND [Pat].[patient_id] IN (SELECT
                                                                                    [PatientId]
                                                                                FROM
                                                                                    @SelectedPatients)
        INNER JOIN [dbo].[int_mrn_map] ON [Pat].[patient_id] = [int_mrn_map].[patient_id]
    WHERE
        ([merge_cd] = 'C')
        AND ((@FilterUV = 1
        AND [mrn_xid] NOT LIKE 'UV_%'
        )
        OR (@FilterUV = 0)
        );
			
    --Get Order data
    SELECT
        [OrderNumber].[Value] [ORDER_ID],
        CAST([OrderStatus].[Value] AS INT) [ORDER_STATUS],
        CAST(NULL AS DATETIME) [ORDER_DATE_TIME],
        [Patients].[PatientId] AS [PATIENT_ID]
    FROM
        (SELECT
            [PatientId]
         FROM
            @SelectedPatients
        ) AS [Patients],
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

    --Patient visit/encounter information
    SELECT DISTINCT
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
        [monitor].[monitor_id] AS [DeviceId]
    FROM
        [dbo].[int_encounter] AS [enc]
        INNER JOIN [dbo].[int_encounter_map] AS [encmap] ON [enc].[encounter_id] = [encmap].[encounter_id]
        INNER JOIN [dbo].[int_patient_monitor] AS [patMon] ON [patMon].[encounter_id] = [enc].[encounter_id]
                                                              AND (([patMon].[active_sw] = 1)
                                                              OR ([enc].[mod_dt] > @LastRunDateTime)
                                                              )
        INNER JOIN [dbo].[int_monitor] AS [monitor] ON [patMon].[monitor_id] = [monitor].[monitor_id]
        INNER JOIN [dbo].[int_organization] AS [organization] ON [organization].[organization_id] = [monitor].[unit_org_id]
    WHERE
        [patMon].[patient_id] IN (SELECT
                                    [PatientId]
                                  FROM
                                    @SelectedPatients)
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
        [PATIENT_ID] IN (SELECT
                            [PatientId]
                         FROM
                            @SelectedPatients)
        AND [STATUS] = 'A'
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
        [VL].[patient_id] IN (SELECT
                                [PatientId]
                              FROM
                                @SelectedPatients)
        AND [VL].[patient_id] = [MRNMAP].[patient_id]
        AND [MRNMAP].[merge_cd] = 'C'
        AND [PM].[patient_id] = [VL].[patient_id]
        AND [PM].[monitor_id] = [VL].[monitor_id]
        AND [VL].[collect_dt] = (SELECT
                                    MAX([VL_SUBTAB].[collect_dt])
                                 FROM
                                    [dbo].[int_vital_live_temp] AS [VL_SUBTAB]
                                 WHERE
                                    [VL_SUBTAB].[monitor_id] = [VL].[monitor_id]
                                    AND [VL_SUBTAB].[patient_id] = [VL].[patient_id]
                                    AND [VL_SUBTAB].[createdDT] > (GETDATE( ) - 0.002)
                                );

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
        [dbo].[fnUtcDateTimeToLocalTime]([VitalsAll].[TimestampUTC]) AS [ResultTime],
        [VitalsAll].[PatientId] AS [PATIENT_ID],
        [DeviceId]
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
            [DeviceSessionId],
            [Description]
         FROM
            [dbo].[LiveData]
            INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[TopicInstanceId] = [LiveData].[TopicInstanceId]
                                                AND [EndTimeUTC] IS NULL
            INNER JOIN [dbo].[GdsCodeMap] ON [GdsCodeMap].[FeedTypeId] = [LiveData].[FeedTypeId]
                                             AND [GdsCodeMap].[Name] = [LiveData].[Name]
            INNER JOIN [dbo].[v_PatientTopicSessions] ON [TopicSessions].[Id] = [TopicSessionId]
         WHERE
            [PatientId] IN (SELECT
                                [PatientId]
                            FROM
                                @SelectedPatients)
        ) [VitalsAll]
        INNER JOIN [dbo].[DeviceSessions] ON [Id] = [VitalsAll].[DeviceSessionId]
    WHERE
        [VitalsAll].[ROW_NUMBER] = 1
        AND [VitalsAll].[Units] IS NOT NULL;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieves the vitals and other patient data of all the active patients to generate the Oru messages', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_GetLiveVitalsAndPatientDataForOru';

