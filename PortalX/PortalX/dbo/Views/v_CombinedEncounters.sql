CREATE VIEW [dbo].[v_CombinedEncounters]
WITH SCHEMABINDING
AS
SELECT
    [vps].[FIRST_NAME],
    [vps].[LAST_NAME],
    [vps].[MRN_ID],
    [vps].[ACCOUNT_ID],
    [vps].[DOB],
    [vps].[FACILITY_ID],
    [vps].[UNIT_ID],
    [vps].[ROOM],
    [vps].[BED],
    [vps].[MONITOR_NAME],
    [LAST_RESULT].[LocalDateTime] AS [LAST_RESULT],
    [ADMIT].[LocalDateTime] AS [ADMIT],
    [DISCHARGED].[LocalDateTime] AS [DISCHARGED],
    [vps].[SUBNET],
    [vps].[patient_id],
    CASE [vps].[STATUS]
        WHEN 'A'
            THEN
            'C'
        WHEN 'S'
            THEN
            'C'
        ELSE
            'D'
    END AS [STATUS_CD],
    1 AS [MONITOR_CREATED],
    [io].[parent_organization_id] AS [FACILITY_PARENT_ID],
    [vps].[PATIENT_MONITOR_ID],
    'C' AS [MERGE_CD]
FROM [dbo].[v_PatientSessions] AS [vps]
    INNER JOIN [dbo].[int_organization] AS [io]
        ON [io].[organization_id] = [vps].[FACILITY_ID]
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[LAST_RESULT_UTC]) AS [LAST_RESULT]
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[ADMIT_TIME_UTC]) AS [ADMIT]
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[DISCHARGED_TIME_UTC]) AS [DISCHARGED]

UNION ALL

SELECT
    ISNULL([iper].[first_nm], '') AS [FIRST_NAME],
    ISNULL([iper].[last_nm], '') AS [LAST_NAME],
    [imm].[mrn_xid] AS [MRN_ID],
    [imm].[mrn_xid2] AS [ACCOUNT_ID],
    [ipat].[dob] AS [DOB],
    [org1].[organization_id] AS [FACILITY_ID],
    [org2].[organization_id] AS [UNIT_ID],
    [ie].[rm] AS [ROOM],
    [ie].[bed] AS [BED],
    [im].[monitor_name] AS [MONITOR_NAME],
    [PM1].[last_result_dt] AS [LAST_RESULT],
    [ie].[admit_dt] AS [ADMIT],
    [ie].[discharge_dt] AS [DISCHARGED],
    [im].[subnet] AS [SUBNET],
    [imm].[patient_id] AS [patient_id],
    [ie].[status_cd] AS [STATUS_CD],
    [ie].[monitor_created] AS [MONITOR_CREATED],
    [org1].[parent_organization_id] AS [FACILITY_PARENT_ID],
    [PM1].[patient_monitor_id] AS [PATIENT_MONITOR_ID],
    [imm].[merge_cd] AS [MERGE_CD]
FROM [dbo].[int_encounter] AS [ie]
    LEFT OUTER JOIN [dbo].[int_organization] AS [org1]
        ON ([ie].[organization_id] = [org1].[organization_id])
    LEFT OUTER JOIN [dbo].[int_patient_monitor] AS [PM1]
        INNER JOIN [dbo].[int_monitor] AS [im]
            ON ([PM1].[monitor_id] = [im].[monitor_id])
        ON ([ie].[encounter_id] = [PM1].[encounter_id])
    LEFT OUTER JOIN [dbo].[int_patient_monitor] AS [PM2]
        ON [PM2].[patient_monitor_id] <> [PM1].[patient_monitor_id]
           AND [ie].[encounter_id] = [PM2].[encounter_id]
           AND [PM1].[last_result_dt] < [PM2].[last_result_dt]
    INNER JOIN [dbo].[int_person] AS [iper]
        ON ([ie].[patient_id] = [iper].[person_id])
    INNER JOIN [dbo].[int_patient] AS [ipat]
        ON ([iper].[person_id] = [ipat].[patient_id])
    INNER JOIN [dbo].[int_mrn_map] AS [imm]
        ON ([ipat].[patient_id] = [imm].[patient_id])
    INNER JOIN [dbo].[int_organization] AS [org2]
        ON ([ie].[unit_org_id] = [org2].[organization_id])
WHERE [PM2].[encounter_id] IS NULL;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_CombinedEncounters';

