CREATE PROCEDURE [dbo].[usp_GetPatientInfo]
    (@PatientId UNIQUEIDENTIFIER)
AS
BEGIN
    SELECT
        [imm].[mrn_xid],
        [imm].[mrn_xid2],
        [iper].[last_nm],
        [iper].[first_nm],
        [iper].[middle_nm],
        [ipat].[dob],
        [imc].[short_dsc],
        [ipat].[height],
        [ipat].[weight],
        [ipat].[bsa],
        [org1].[organization_cd] + N' - ' + [org2].[organization_cd] AS [Unit],
        [ie].[rm],
        [ie].[bed],
        [iem].[encounter_xid],
        CAST(0 AS TINYINT) AS [IsDataLoader],
        [ipm].[last_result_dt] AS [Precedence]
    FROM [dbo].[int_encounter] AS [ie]
        LEFT OUTER JOIN [dbo].[int_organization] AS [org1]
            ON ([ie].[organization_id] = [org1].[organization_id])
        LEFT OUTER JOIN [dbo].[int_patient_monitor] AS [ipm]
            INNER JOIN [dbo].[int_monitor] AS [im]
                ON ([ipm].[monitor_id] = [im].[monitor_id])
            ON ([ie].[encounter_id] = [ipm].[encounter_id])
               AND ([ie].[patient_id] = [ipm].[patient_id])
        INNER JOIN [dbo].[int_encounter_map] AS [iem]
            ON ([ie].[encounter_id] = [iem].[encounter_id])
        INNER JOIN [dbo].[int_person] AS [iper]
            ON ([ie].[patient_id] = [iper].[person_id])
        INNER JOIN [dbo].[int_patient] AS [ipat]
            ON ([iper].[person_id] = [ipat].[patient_id])
        INNER JOIN [dbo].[int_mrn_map] AS [imm]
            ON ([ipat].[patient_id] = [imm].[patient_id])
        INNER JOIN [dbo].[int_organization] AS [org2]
            ON ([ie].[unit_org_id] = [org2].[organization_id])
        LEFT OUTER JOIN [dbo].[int_misc_code] AS [imc]
            ON [ipat].[gender_cid] = [imc].[code_id]
    WHERE [imm].[merge_cd] = 'C'
          AND [imm].[patient_id] = @PatientId
    UNION
    SELECT
        [imm].[mrn_xid],
        [imm].[mrn_xid2],
        [iper2].[last_nm],
        [iper2].[first_nm],
        [iper2].[middle_nm],
        [ip].[dob],
        [imc].[short_dsc],
        [ip].[height],
        [ip].[weight],
        [ip].[bsa],
        [Facilities].[organization_cd] + N' - ' + [Units].[organization_cd] AS [Unit],
        [d].[Room] AS [rm],
        [Assignment].[BedName] AS [bed],
        CAST(NULL AS NVARCHAR(40)) AS [encounter_xid],
        CAST(1 AS TINYINT) AS [IsDataLoader],
        [Precedence].[LocalDateTime] AS [Precedence]
    FROM [dbo].[PatientSessions] AS [ps] -- From the patient session, get to the patient
        INNER JOIN (SELECT
                        [PatientSessionsAssignmentSequence].[PatientSessionId],
                        [PatientSessionsAssignmentSequence].[PatientId]
                    FROM (SELECT
                              [psm].[PatientSessionId],
                              [psm].[PatientId],
                              ROW_NUMBER() OVER (PARTITION BY [psm].[PatientSessionId]
                                                 ORDER BY [psm].[Sequence] DESC) AS [RowNumber]
                          FROM [dbo].[PatientSessionsMap] AS [psm]) AS [PatientSessionsAssignmentSequence]
                    WHERE [PatientSessionsAssignmentSequence].[RowNumber] = 1) AS [LatestPatientSessionAssignment]
            ON [LatestPatientSessionAssignment].[PatientSessionId] = [ps].[Id]

        -- From the patient session, get to the device and ID1
        INNER JOIN (SELECT
                        [PatientSessionsDeviceSequence].[PatientSessionId],
                        [PatientSessionsDeviceSequence].[DeviceSessionId]
                    FROM (SELECT
                              [pd].[PatientSessionId],
                              [pd].[DeviceSessionId],
                              ROW_NUMBER() OVER (PARTITION BY [pd].[PatientSessionId]
                                                 ORDER BY [pd].[TimestampUTC] DESC) AS [RowNumber]
                          FROM [dbo].[PatientData] AS [pd]) AS [PatientSessionsDeviceSequence]
                    WHERE [PatientSessionsDeviceSequence].[RowNumber] = 1) AS [LatestPatientSessionDevice]
            ON [LatestPatientSessionDevice].[PatientSessionId] = [ps].[Id]
        INNER JOIN [dbo].[DeviceSessions] AS [ds]
            ON [ds].[Id] = [LatestPatientSessionDevice].[DeviceSessionId]
        INNER JOIN [dbo].[Devices] AS [d]
            ON [ds].[DeviceId] = [d].[Id]

        -- From the device, get to the facility and units
        INNER JOIN [dbo].[v_DeviceSessionAssignment] AS [Assignment]
            ON [Assignment].[DeviceSessionId] = [LatestPatientSessionDevice].[DeviceSessionId]
        LEFT OUTER JOIN [dbo].[int_organization] AS [Facilities]
            ON [Facilities].[organization_nm] = [Assignment].[FacilityName]
               AND [Facilities].[category_cd] = 'F'
        LEFT OUTER JOIN [dbo].[int_organization] AS [Units]
            ON [Units].[organization_nm] = [Assignment].[UnitName]
               AND [Units].[parent_organization_id] = [Facilities].[organization_id]
        LEFT OUTER JOIN [dbo].[int_mrn_map] AS [imm]
            ON [imm].[patient_id] = [LatestPatientSessionAssignment].[PatientId]
               AND [imm].[merge_cd] = 'C'
        LEFT OUTER JOIN [dbo].[int_patient] AS [ip]
            ON [ip].[patient_id] = [LatestPatientSessionAssignment].[PatientId]
        LEFT OUTER JOIN [dbo].[int_person] AS [iper2]
            ON [iper2].[person_id] = [LatestPatientSessionAssignment].[PatientId]
        LEFT OUTER JOIN [dbo].[int_misc_code] AS [imc]
            ON [imc].[code_id] = [ip].[gender_cid]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([ps].[BeginTimeUTC]) AS [Precedence]
    WHERE [LatestPatientSessionAssignment].[PatientId] = @PatientId
    ORDER BY [Precedence] DESC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Inline queries to SPs/ICS Admin Component.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetPatientInfo';

