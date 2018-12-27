﻿CREATE PROCEDURE [dbo].[GetPatientMonitorData]
    (@PatientId UNIQUEIDENTIFIER)
AS
BEGIN
    SELECT
        [pm].[patient_monitor_id] AS [PATIENT_MONITOR_ID],
        [pm].[patient_id] AS [patient_id],
        [mrn].[mrn_xid] AS [MRN_XID],
        [p].[first_nm] AS [FIRST_NAME],
        [p].[last_nm] AS [LAST_NAME],
        [m].[monitor_name] AS [MONITOR_NAME],
        [pm].[monitor_connect_dt] AS [MONITOR_CONNECT_DT]
    FROM [dbo].[int_patient_monitor] AS [pm]
        INNER JOIN [dbo].[int_monitor] AS [m]
            ON [m].[monitor_id] = [pm].[monitor_id]
        INNER JOIN [dbo].[int_mrn_map] AS [mrn]
            ON [mrn].[patient_id] = [pm].[patient_id]
               AND [mrn].[merge_cd] = 'C'
        INNER JOIN [dbo].[int_person] AS [p]
            ON [p].[person_id] = [pm].[patient_id]
    WHERE [pm].[patient_id] = @PatientId

    UNION ALL

    SELECT
        [vps].[PATIENT_MONITOR_ID],
        [vps].[patient_id],
        [vps].[MRN_ID] AS [MRN_XID],
        [vps].[FIRST_NAME],
        [vps].[LAST_NAME],
        [vps].[MONITOR_NAME],
        [MONITOR_CONNECT_DT].[LocalDateTime] AS [MONITOR_CONNECT_DT]
    FROM [dbo].[v_PatientSessions] AS [vps]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[ADMIT_TIME_UTC]) AS [MONITOR_CONNECT_DT]
    WHERE [vps].[patient_id] = @PatientId;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientMonitorData';

