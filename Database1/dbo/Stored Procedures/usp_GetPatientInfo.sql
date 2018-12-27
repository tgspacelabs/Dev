
--in line queries to SPs/ICS Admin Component
CREATE PROCEDURE [dbo].[usp_GetPatientInfo]
    (
     @PatientID UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [mrn_xid],
        [mrn_xid2],
        [last_nm],
        [first_nm],
        [middle_nm],
        [dob],
        [short_dsc],
        [height],
        [weight],
        [bsa],
        [org1].[organization_cd] + ' - ' + [org2].[organization_cd] AS [Unit],
        [rm],
        [bed],
        [encounter_xid],
        CAST(0 AS TINYINT) AS [IsDataLoader],
        [last_result_dt] AS [Precedence]
    FROM
        [dbo].[int_encounter]
        LEFT OUTER JOIN [dbo].[int_organization] AS [org1] ON ([int_encounter].[organization_id] = [org1].[organization_id])
        LEFT OUTER JOIN [dbo].[int_patient_monitor]
        INNER JOIN [dbo].[int_monitor] ON ([int_patient_monitor].[monitor_id] = [int_monitor].[monitor_id]) ON ([int_encounter].[encounter_id] = [int_patient_monitor].[encounter_id])
                                                                                                               AND ([int_encounter].[patient_id] = [int_patient_monitor].[patient_id])
        INNER JOIN [dbo].[int_encounter_map] ON ([int_encounter].[encounter_id] = [int_encounter_map].[encounter_id])
        INNER JOIN [dbo].[int_person] ON ([int_encounter].[patient_id] = [person_id])
        INNER JOIN [dbo].[int_patient] ON ([person_id] = [int_patient].[patient_id])
        INNER JOIN [dbo].[int_mrn_map] ON ([int_patient].[patient_id] = [int_mrn_map].[patient_id])
        INNER JOIN [dbo].[int_organization] AS [org2] ON ([int_encounter].[unit_org_id] = [org2].[organization_id])
        LEFT OUTER JOIN [dbo].[int_misc_code] ON [gender_cid] = [code_id]
    WHERE
        ([merge_cd] = 'C')
        AND [int_mrn_map].[patient_id] = @PatientID
    UNION
    SELECT
        [mrn_xid],
        [mrn_xid2],
        [last_nm],
        [first_nm],
        [middle_nm],
        [dob],
        [short_dsc],
        [height],
        [weight],
        [bsa],
        [Facilities].[organization_cd] + ' - ' + [Units].[organization_cd] AS [Unit],
        [Room] AS [rm],
        [Assignment].[BedName] AS [bed],
        [encounter_xid] = CAST(NULL AS NVARCHAR(40)),
        [IsDataLoader] = CAST(1 AS TINYINT),
        [dbo].[fnUtcDateTimeToLocalTime]([PatientSessions].[BeginTimeUTC]) AS [Precedence]
    FROM
        [dbo].[PatientSessions] -- From the patient session, get to the patient
        INNER JOIN (SELECT
                        [PatientSessionsAssignmentSequence].[PatientSessionId],
                        [PatientSessionsAssignmentSequence].[PatientId]
                    FROM
                        (SELECT
                            [PatientSessionId],
                            [PatientId],
                            [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                         FROM
                            [dbo].[PatientSessionsMap]
                        ) AS [PatientSessionsAssignmentSequence]
                    WHERE
                        [PatientSessionsAssignmentSequence].[R] = 1
                   ) AS [LatestPatientSessionAssignment] ON [LatestPatientSessionAssignment].[PatientSessionId] = [PatientSessions].[Id]

-- From the patient session, get to the device and ID1
        INNER JOIN (SELECT
                        [PatientSessionsDeviceSequence].[PatientSessionId],
                        [PatientSessionsDeviceSequence].[DeviceSessionId]
                    FROM
                        (SELECT
                            [PatientSessionId],
                            [DeviceSessionId],
                            [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
                         FROM
                            [dbo].[PatientData]
                        ) AS [PatientSessionsDeviceSequence]
                    WHERE
                        [PatientSessionsDeviceSequence].[R] = 1
                   ) AS [LatestPatientSessionDevice] ON [LatestPatientSessionDevice].[PatientSessionId] = [PatientSessions].[Id]
        INNER JOIN [dbo].[DeviceSessions] ON [DeviceSessions].[Id] = [LatestPatientSessionDevice].[DeviceSessionId]
        INNER JOIN [dbo].[Devices] ON [DeviceId] = [Devices].[Id]

-- From the device, get to the facility and units
        INNER JOIN [dbo].[v_DeviceSessionAssignment] [Assignment] ON [Assignment].[DeviceSessionId] = [LatestPatientSessionDevice].[DeviceSessionId]
        LEFT OUTER JOIN [dbo].[int_organization] AS [Facilities] ON [Facilities].[organization_nm] = [Assignment].[FacilityName]
                                                                    AND [Facilities].[category_cd] = 'F'
        LEFT OUTER JOIN [dbo].[int_organization] AS [Units] ON [Units].[organization_nm] = [Assignment].[UnitName]
                                                               AND [Units].[parent_organization_id] = [Facilities].[organization_id]
        LEFT OUTER JOIN [dbo].[int_mrn_map] ON [int_mrn_map].[patient_id] = [LatestPatientSessionAssignment].[PatientId]
                                               AND [merge_cd] = 'C'
        LEFT OUTER JOIN [dbo].[int_patient] ON [int_patient].[patient_id] = [LatestPatientSessionAssignment].[PatientId]
        LEFT OUTER JOIN [dbo].[int_person] ON [person_id] = [LatestPatientSessionAssignment].[PatientId]
        LEFT OUTER JOIN [dbo].[int_misc_code] ON [code_id] = [gender_cid]
    WHERE
        [LatestPatientSessionAssignment].[PatientId] = @PatientID
    ORDER BY
        [Precedence] DESC;
                                                        
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Inline queries to SPs/ICS Admin Component.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetPatientInfo';

