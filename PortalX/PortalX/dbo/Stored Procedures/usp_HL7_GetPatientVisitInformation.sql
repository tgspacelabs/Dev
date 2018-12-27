CREATE PROCEDURE [dbo].[usp_HL7_GetPatientVisitInformation]
    (
    @patient_id UNIQUEIDENTIFIER,
    @monitor_id [dbo].[MonitorIdTable] READONLY)
AS
BEGIN
    SET NOCOUNT ON;

    IF ((SELECT COUNT(*)FROM @monitor_id) > 0 AND @patient_id IS NOT NULL)
    BEGIN
        SELECT TOP 1
               [enc].[patient_type_cid] AS [PatientType],
               [enc].[med_svc_cid] AS [HospService],
               [enc].[patient_class_cid] AS [PatientClass],
               [enc].[ambul_status_cid] AS [AmbulatorySts],
               [enc].[vip_sw] AS [VipIndic],
               [enc].[discharge_dispo_cid] AS [DischDisposition],
               [enc].[admit_dt] AS [AdmitDate],
               [enc].[discharge_dt] AS [DischargeDt],
               [encmap].[encounter_xid] AS [VisitNumber],
               [encmap].[seq_no] AS [SeqNo],
               [monitor].[monitor_name] AS [NodeName],
               [monitor].[node_id] AS [NodeId],
               [monitor].[room] AS [Room],
               [monitor].[bed_cd] AS [Bed],
               [organization].[organization_cd] AS [UnitName]
        FROM [dbo].[int_encounter] AS [enc]
            INNER JOIN [dbo].[int_encounter_map] AS [encmap]
                ON [enc].[encounter_id] = [encmap].[encounter_id]
            INNER JOIN [dbo].[int_patient_monitor] AS [patMon]
                ON [patMon].[encounter_id] = [enc].[encounter_id]
                   AND [patMon].[active_sw] = 1
            INNER JOIN [dbo].[int_monitor] AS [monitor]
                ON [patMon].[monitor_id] = [monitor].[monitor_id]
            INNER JOIN [dbo].[int_organization] AS [organization]
                ON [organization].[organization_id] = [monitor].[unit_org_id]
        WHERE [patMon].[patient_id] = @patient_id
              AND [monitor].[monitor_id] IN (SELECT [Monitor_Id] FROM @monitor_id)

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
               CAST(NULL AS INT) AS [SeqNo],
               [vps].[MONITOR_NAME] AS [NodeName],
               CAST(NULL AS NVARCHAR(15)) AS [NodeId],
               [vps].[ROOM] AS [Room],
               [vps].[BED] AS [Bed],
               [vps].[UNIT_NAME] AS [UnitName]
        FROM [dbo].[v_PatientSessions] AS [vps]
            CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[ADMIT_TIME_UTC]) AS [AdmitDate]
            CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[DISCHARGED_TIME_UTC]) AS [DischargeDt]
        WHERE [vps].[patient_id] = @patient_id
              AND [vps].[PATIENT_MONITOR_ID] IN (SELECT [mi].[Monitor_Id] FROM @monitor_id AS [mi])
        ORDER BY [AdmitDate] DESC;
    END;
    ELSE
    BEGIN
        SELECT TOP (1)
               [enc].[patient_type_cid] AS [PatientType],
               [enc].[med_svc_cid] AS [HospService],
               [enc].[patient_class_cid] AS [PatientClass],
               [enc].[ambul_status_cid] AS [AmbulatorySts],
               [enc].[vip_sw] AS [VipIndic],
               [enc].[discharge_dispo_cid] AS [DischDisposition],
               [enc].[admit_dt] AS [AdmitDate],
               [enc].[discharge_dt] AS [DischargeDt],
               [encmap].[encounter_xid] AS [VisitNumber],
               [encmap].[seq_no] AS [SeqNo],
               [monitor].[monitor_name] AS [NodeName],
               [monitor].[node_id] AS [NodeId],
               [monitor].[room] AS [Room],
               [monitor].[bed_cd] AS [Bed],
               [organization].[organization_cd] AS [UnitName]
        FROM [dbo].[int_encounter] AS [enc]
            INNER JOIN [dbo].[int_encounter_map] AS [encmap]
                ON [enc].[encounter_id] = [encmap].[encounter_id]
            INNER JOIN [dbo].[int_patient_monitor] AS [patMon]
                ON [patMon].[encounter_id] = [enc].[encounter_id]
                   AND [patMon].[active_sw] = 1
            INNER JOIN [dbo].[int_monitor] AS [monitor]
                ON [patMon].[monitor_id] = [monitor].[monitor_id]
            INNER JOIN [dbo].[int_organization] AS [organization]
                ON [organization].[organization_id] = [monitor].[unit_org_id]
        WHERE [patMon].[patient_id] = @patient_id

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
               CAST(NULL AS INT) AS [SeqNo],
               [vps].[MONITOR_NAME] AS [NodeName],
               CAST(NULL AS NVARCHAR(15)) AS [NodeId],
               [vps].[ROOM] AS [Room],
               [vps].[BED] AS [Bed],
               [vps].[UNIT_NAME] AS [UnitName]
        FROM [dbo].[v_PatientSessions] AS [vps]
            CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[ADMIT_TIME_UTC]) AS [AdmitDate]
            CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[DISCHARGED_TIME_UTC]) AS [DischargeDt]
        WHERE [vps].[patient_id] = @patient_id
        ORDER BY [AdmitDate] DESC;
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get patient visit data.  1) Query by Patient Id  2) Query by Patient Id and Monitor Id', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_GetPatientVisitInformation';

