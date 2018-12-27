CREATE PROCEDURE [dbo].[GetPatientByExternalIdAndDevice]
    (
    @mrn_id AS NVARCHAR(30),
    @device AS NVARCHAR(30) = NULL,
    @login_name NVARCHAR(64),
    @is_vip_searchable NVARCHAR(4),
    @is_restricted_unit_searchable NVARCHAR(4))
AS
BEGIN
    SELECT
        [imm].[patient_id] AS [PATIENT_ID],
        CONCAT([iper].[last_nm], N', ', [iper].[first_nm]) AS [PATIENT_NAME],
        [im].[monitor_name] AS [MONITOR_NAME],
        [imm].[mrn_xid2] AS [ACCOUNT_ID],
        [imm].[mrn_xid] AS [MRN_ID],
        [ORG1].[organization_id] AS [UNIT_ID],
        [ORG1].[organization_cd] AS [UNIT_NAME],
        [ORG2].[organization_id] AS [FACILITY_ID],
        [ORG2].[organization_nm] AS [FACILITY_NAME],
        [ipat].[dob] AS [DOB],
        [ie].[admit_dt] AS [ADMIT_TIME],
        [ie].[discharge_dt] AS [DISCHARGED_TIME],
        [ipm].[patient_monitor_id] AS [PATIENT_MONITOR_ID],
        CASE
            WHEN [ie].[discharge_dt] IS NULL
                THEN
                'A'
            ELSE
                'D'
        END AS [STATUS]
    FROM [dbo].[int_mrn_map] AS [imm]
        INNER JOIN [dbo].[int_patient_monitor] AS [ipm]
            ON [ipm].[patient_id] = [imm].[patient_id]
        INNER JOIN [dbo].[int_encounter] AS [ie]
            ON [ie].[encounter_id] = [ipm].[encounter_id]
               AND (@is_vip_searchable = '1'
                    OR [ie].[vip_sw] IS NULL)
        INNER JOIN [dbo].[int_monitor] AS [im]
            ON [im].[monitor_id] = [ipm].[monitor_id]
               AND (@device IS NULL
                    OR [im].[node_id] = @device)
        LEFT OUTER JOIN [dbo].[int_person] AS [iper]
            ON [iper].[person_id] = [imm].[patient_id]
        LEFT OUTER JOIN [dbo].[int_patient] AS [ipat]
            ON [ipat].[patient_id] = [imm].[patient_id]
        INNER JOIN [dbo].[int_organization] AS [ORG1]
            ON ([im].[unit_org_id] = [ORG1].[organization_id])
               AND (@is_restricted_unit_searchable = N'1'
                    OR [ORG1].[organization_id] NOT IN (SELECT [organization_id]
                                                        FROM [dbo].[cdr_restricted_organization]
                                                        WHERE [user_role_id] = (SELECT [user_role_id]
                                                                                FROM [dbo].[int_user]
                                                                                WHERE [login_name] = @login_name)))
        LEFT OUTER JOIN [dbo].[int_organization] AS [ORG2]
            ON [ORG2].[organization_id] = [ORG1].[parent_organization_id]
    WHERE [imm].[mrn_xid] = @mrn_id
          AND [imm].[merge_cd] = 'C'

    UNION ALL

    SELECT
        [imm].[patient_id] AS [PATIENT_ID],
        CONCAT([iper].[last_nm], N', ', [iper].[first_nm]) AS [PATIENT_NAME],
        CASE
            WHEN [Assignment].[BedName] IS NULL
                 OR [Assignment].[MonitorName] IS NULL
                THEN
                [d].[Name]
            ELSE
                RTRIM([Assignment].[BedName]) + N'(' + RTRIM([Assignment].[Channel]) + N')'
        END AS [MONITOR_NAME],
        [imm].[mrn_xid2] AS [ACCOUNT_ID],
        [imm].[mrn_xid] AS [MRN_ID],
        [Units].[organization_id] AS [UNIT_ID],
        [Units].[organization_nm] AS [UNIT_NAME],
        [Facilities].[organization_id] AS [FACILITY_ID],
        [Facilities].[organization_nm] AS [FACILITY_NAME],
        [ipat].[dob] AS [DOB],
        [ADMIT_TIMEC].[LocalDateTime] AS [ADMIT_TIMEC],
        [DISCHARGED_TIME].[LocalDateTime] AS [DISCHARGED_TIME],
        [ps].[Id] AS [PATIENT_MONITOR_ID],
        CASE
            WHEN [ps].[EndTimeUTC] IS NULL
                THEN
                'A'
            ELSE
                'D'
        END AS [STATUS]
    FROM [dbo].[int_mrn_map] AS [imm]
        INNER JOIN [dbo].[PatientSessionsMap] AS [psm]
            ON [psm].[PatientId] = [imm].[patient_id]
        INNER JOIN (SELECT
                        [psm2].[PatientSessionId],
                        MAX([psm2].[Sequence]) AS [MaxSeq]
                    FROM [dbo].[PatientSessionsMap] AS [psm2]
                    GROUP BY [psm2].[PatientSessionId]) AS [PatientSessionMaxSeq]
            ON [PatientSessionMaxSeq].[PatientSessionId] = [psm].[PatientSessionId]
               AND [PatientSessionMaxSeq].[MaxSeq] = [psm].[Sequence]
        INNER JOIN [dbo].[PatientSessions] AS [ps]
            ON [ps].[Id] = [psm].[PatientSessionId]
        INNER JOIN (SELECT
                        [PatientSessionsDeviceSequence].[PatientSessionId],
                        [PatientSessionsDeviceSequence].[DeviceSessionId]
                    FROM (SELECT
                              [pd].[PatientSessionId],
                              [pd].[DeviceSessionId],
                              ROW_NUMBER() OVER (PARTITION BY [pd].[PatientSessionId]
                                                 ORDER BY [pd].[TimestampUTC] DESC) AS [R]
                          FROM [dbo].[PatientData] AS [pd]) AS [PatientSessionsDeviceSequence]
                    WHERE [PatientSessionsDeviceSequence].[R] = 1) AS [LatestPatientSessionDevice]
            ON [LatestPatientSessionDevice].[PatientSessionId] = [ps].[Id]
        INNER JOIN [dbo].[DeviceSessions] AS [ds]
            ON [ds].[Id] = [LatestPatientSessionDevice].[DeviceSessionId]
        INNER JOIN [dbo].[Devices] AS [d]
            ON [ds].[DeviceId] = [d].[Id]
               AND (@device IS NULL
                    OR [d].[Name] = @device)
        INNER JOIN [dbo].[v_DeviceSessionAssignment] AS [Assignment]
            ON [Assignment].[DeviceSessionId] = [LatestPatientSessionDevice].[DeviceSessionId]
        LEFT OUTER JOIN [dbo].[int_organization] AS [Facilities]
            ON [Facilities].[organization_nm] = [Assignment].[FacilityName]
               AND [Facilities].[category_cd] = 'F'
        LEFT OUTER JOIN [dbo].[int_organization] AS [Units]
            ON [Units].[organization_nm] = [Assignment].[UnitName]
               AND [Units].[parent_organization_id] = [Facilities].[organization_id]
               AND (@is_restricted_unit_searchable = N'1'
                    OR [Units].[organization_id] NOT IN (SELECT [organization_id]
                                                         FROM [dbo].[cdr_restricted_organization]
                                                         WHERE [user_role_id] = (SELECT [user_role_id]
                                                                                 FROM [dbo].[int_user]
                                                                                 WHERE [login_name] = @login_name)))
        LEFT OUTER JOIN [dbo].[int_patient] AS [ipat]
            ON [ipat].[patient_id] = [imm].[patient_id]
        LEFT OUTER JOIN [dbo].[int_person] AS [iper]
            ON [iper].[person_id] = [imm].[patient_id]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([ps].[BeginTimeUTC]) AS [ADMIT_TIMEC]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([ps].[EndTimeUTC]) AS [DISCHARGED_TIME]
    WHERE [imm].[mrn_xid] = @mrn_id
          AND [imm].[merge_cd] = 'C'
    ORDER BY [ADMIT_TIME] DESC,
             [STATUS],
             [PATIENT_NAME],
             [MONITOR_NAME];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the patient information by the external medical record ID and device name.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientByExternalIdAndDevice';

