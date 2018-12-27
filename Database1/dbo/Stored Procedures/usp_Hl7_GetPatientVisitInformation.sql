﻿
/*[usp_Hl7_GetPV1SegmentData] used to get patient visit data
1)Query by Patient Id
2)Query by patient Id and Monitor Id*/
CREATE PROCEDURE [dbo].[usp_Hl7_GetPatientVisitInformation]
    (
     @patient_id UNIQUEIDENTIFIER,
     @monitor_id MonitorIdTable READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF ((SELECT
            COUNT(*)
         FROM
            @monitor_id
        ) > 0
        AND @patient_id IS NOT NULL
        )
    BEGIN
        SELECT TOP 1
            [enc].[patient_type_cid] [PatientType],
            [enc].[med_svc_cid] [HospService],
            [enc].[patient_class_cid] [PatientClass],
            [enc].[ambul_status_cid] [AmbulatorySts],
            [enc].[vip_sw] [VipIndic],
            [enc].[discharge_dispo_cid] [DischDisposition],
            [enc].[admit_dt] [AdmitDate],
            [enc].[discharge_dt] [DischargeDt],
            [encmap].[encounter_xid] [VisitNumber],
            [encmap].[seq_no] [SeqNo],
            [monitor].[monitor_name] [NodeName],
            [monitor].[node_id] [NodeId],
            [monitor].[room] [Room],
            [monitor].[bed_cd] [Bed],
            [organization].[organization_cd] [UnitName]
        FROM
            [dbo].[int_encounter] AS [enc]
            INNER JOIN [dbo].[int_encounter_map] AS [encmap] ON [enc].[encounter_id] = [encmap].[encounter_id]
            INNER JOIN [dbo].[int_patient_monitor] AS [patMon] ON [patMon].[encounter_id] = [enc].[encounter_id]
                                                        AND [patMon].[active_sw] = 1
            INNER JOIN [dbo].[int_monitor] AS [monitor] ON [patMon].[monitor_id] = [monitor].[monitor_id]
            INNER JOIN [dbo].[int_organization] AS [organization] ON [organization].[organization_id] = [monitor].[unit_org_id]
        WHERE
            [patMon].[patient_id] = @patient_id
            AND [monitor].[monitor_id] IN (SELECT
                                        [Monitor_Id]
                                       FROM
                                        @monitor_id)
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
            [SeqNo] = CAST(NULL AS INT),
            [NodeName] = [MONITOR_NAME],
            [NodeId] = CAST(NULL AS NVARCHAR(15)),
            [Room] = [ROOM],
            [Bed] = [BED],
            [UnitName] = [UNIT_NAME]
        FROM
            [dbo].[v_PatientSessions]
        WHERE
            [PATIENT_ID] = @patient_id
            AND [PATIENT_MONITOR_ID] IN (SELECT
                                        [Monitor_Id]
                                       FROM
                                        @monitor_id)
        ORDER BY
            [AdmitDate] DESC;
    END;
    ELSE
    BEGIN
        SELECT TOP 1
            [enc].[patient_type_cid] [PatientType],
            [enc].[med_svc_cid] [HospService],
            [enc].[patient_class_cid] [PatientClass],
            [enc].[ambul_status_cid] [AmbulatorySts],
            [enc].[vip_sw] [VipIndic],
            [enc].[discharge_dispo_cid] [DischDisposition],
            [enc].[admit_dt] [AdmitDate],
            [enc].[discharge_dt] [DischargeDt],
            [encmap].[encounter_xid] [VisitNumber],
            [encmap].[seq_no] [SeqNo],
            [monitor].[monitor_name] [NodeName],
            [monitor].[node_id] [NodeId],
            [monitor].[room] [Room],
            [monitor].[bed_cd] [Bed],
            [organization].[organization_cd] [UnitName]
        FROM
            [dbo].[int_encounter] AS [enc]
            INNER JOIN [dbo].[int_encounter_map] AS [encmap] ON [enc].[encounter_id] = [encmap].[encounter_id]
            INNER JOIN [dbo].[int_patient_monitor] AS [patMon] ON [patMon].[encounter_id] = [enc].[encounter_id]
                                                        AND [patMon].[active_sw] = 1
            INNER JOIN [dbo].[int_monitor] AS [monitor] ON [patMon].[monitor_id] = [monitor].[monitor_id]
            INNER JOIN [dbo].[int_organization] AS [organization] ON [organization].[organization_id] = [monitor].[unit_org_id]
        WHERE
            [patMon].[patient_id] = @patient_id
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
            [SeqNo] = CAST(NULL AS INT),
            [NodeName] = [MONITOR_NAME],
            [NodeId] = CAST(NULL AS NVARCHAR(15)),
            [Room] = [ROOM],
            [Bed] = [BED],
            [UnitName] = [UNIT_NAME]
        FROM
            [dbo].[v_PatientSessions]
        WHERE
            [PATIENT_ID] = @patient_id
        ORDER BY
            [AdmitDate] DESC;
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get patient visit data.  1) Query by Patient Id  2) Query by Patient Id and Monitor Id', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_Hl7_GetPatientVisitInformation';

