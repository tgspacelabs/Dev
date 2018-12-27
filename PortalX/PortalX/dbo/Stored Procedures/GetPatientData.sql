CREATE PROCEDURE [dbo].[GetPatientData]
    (@PatientId [dbo].[DPATIENT_ID] -- TG - Should be UNIQUEIDENTIFIER
)
AS
BEGIN
    SELECT
        ISNULL([iper].[last_nm], '') + ISNULL(', ' + [iper].[first_nm], '') AS [patient_name],
        [im].[monitor_name] AS [MONITOR_NAME],
        [imm].[mrn_xid2] AS [ACCOUNT_ID],
        [imm].[mrn_xid] AS [MRN_ID],
        [im].[unit_org_id] AS [UNIT_ID],
        [CHILD].[organization_cd] AS [UNIT_NAME],
        [PARENT].[organization_id] AS [FACILITY_ID],
        [PARENT].[organization_nm] AS [FACILITY_NAME],
        [ipat].[dob] AS [DOB],
        [ie].[admit_dt] AS [ADMIT_TIME],
        [ie].[discharge_dt] AS [DISCHARGED_TIME],
        [ipm].[patient_monitor_id] AS [PATIENT_MONITOR_ID],
        CASE
            WHEN [ie].[discharge_dt] IS NULL
                 AND ISNULL([im].[standby], 0) <> 1
                THEN
                'A' -- active
            WHEN [ie].[discharge_dt] IS NULL
                 AND ISNULL([im].[standby], 0) = 1
                THEN
                'S' -- standby
            ELSE
                'D' -- discharged
        END AS [STATUS],
        [ipm].[last_result_dt] AS [PRECEDENCE]
    FROM [dbo].[int_mrn_map] AS [imm]
        INNER JOIN [dbo].[int_patient] AS [ipat]
            ON [ipat].[patient_id] = [imm].[patient_id]
        INNER JOIN [dbo].[int_person] AS [iper]
            ON [iper].[person_id] = [imm].[patient_id]
        INNER JOIN [dbo].[int_encounter] AS [ie]
            ON [ie].[patient_id] = [imm].[patient_id]
        INNER JOIN [dbo].[int_patient_monitor] AS [ipm]
            ON ([ie].[encounter_id] = [ipm].[encounter_id])
        INNER JOIN [dbo].[int_monitor] AS [im]
            ON ([ipm].[monitor_id] = [im].[monitor_id])
        INNER JOIN [dbo].[int_organization] AS [CHILD]
            ON ([im].[unit_org_id] = [CHILD].[organization_id])
        LEFT OUTER JOIN [dbo].[int_organization] AS [PARENT]
            ON [PARENT].[organization_id] = [CHILD].[parent_organization_id]
    WHERE [imm].[patient_id] = CAST(@PatientId AS UNIQUEIDENTIFIER)
          AND [imm].[merge_cd] = 'C'

    UNION

    SELECT
        [vps].[patient_name],
        [vps].[MONITOR_NAME],
        [vps].[ACCOUNT_ID],
        [vps].[MRN_ID],
        [vps].[UNIT_ID],
        [vps].[UNIT_NAME],
        [vps].[FACILITY_ID],
        [vps].[FACILITY_NAME],
        [vps].[DOB],
        [ADMIT_TIME].[LocalDateTime] AS [ADMIT_TIME],
        [DISCHARGED_TIME].[LocalDateTime] AS [DISCHARGED_TIME],
        [vps].[PATIENT_MONITOR_ID],
        [vps].[STATUS],
        ISNULL([PRECEDENCE].[LocalDateTime], GETUTCDATE()) AS [PRECEDENCE]
    FROM [dbo].[v_PatientSessions] AS [vps]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[ADMIT_TIME_UTC]) AS [ADMIT_TIME]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[DISCHARGED_TIME_UTC]) AS [DISCHARGED_TIME]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[DISCHARGED_TIME_UTC]) AS [PRECEDENCE]
    WHERE [vps].[patient_id] = @PatientId
    ORDER BY [STATUS] ASC,
             [PRECEDENCE] DESC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientData';

