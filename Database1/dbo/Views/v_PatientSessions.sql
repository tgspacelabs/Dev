﻿CREATE VIEW [dbo].[v_PatientSessions]
WITH
     SCHEMABINDING
AS
SELECT
    [LatestPatientSessionAssignment].[PatientId] AS [PATIENT_ID],
    CONCAT([last_nm], N', ', [first_nm]) AS [PATIENT_NAME],
    [first_nm] AS [FIRST_NAME],
    [middle_nm] AS [MIDDLE_NAME],
    [last_nm] AS [LAST_NAME],
    CASE WHEN [Assignment].[BedName] IS NULL
              OR [Assignment].[MonitorName] IS NULL THEN CAST([Name] AS NVARCHAR(100))
         ELSE RTRIM([Assignment].[BedName]) + N'(' + RTRIM([Assignment].[Channel]) + N')'
    END AS [MONITOR_NAME],
    [Units].[organization_nm] AS [UNIT_NAME],
    [Units].[organization_cd] AS [UNIT_CODE],
    [Units].[organization_id] AS [UNIT_ID],
    [Facilities].[organization_nm] AS [FACILITY_NAME],
    [Facilities].[organization_cd] AS [FACILITY_CODE],
    [Facilities].[organization_id] AS [FACILITY_ID],
    [mrn_xid2] AS [ACCOUNT_ID],
    [mrn_xid] AS [MRN_ID],
    [dob] AS [DOB],
    [PatientSessions].[BeginTimeUTC] AS [ADMIT_TIME_UTC],
    [PatientSessions].[EndTimeUTC] AS [DISCHARGED_TIME_UTC],
    [tsmax].[MaxTime] AS [LAST_RESULT_UTC],
    [PatientSessions].[Id] AS [PATIENT_MONITOR_ID],
    CASE WHEN [PatientSessions].[EndTimeUTC] IS NULL THEN 'A'
         ELSE 'D'
    END AS [STATUS],
    [Facilities].[parent_organization_id] AS [FACILITY_PARENT_ID],
    [Room] AS [ROOM],
    [Assignment].[BedName] AS [BED],
    CAST(NULL AS NVARCHAR(50)) AS [SUBNET],
    [DeviceId] AS [DeviceId]
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
    INNER JOIN (SELECT
                    [PatientSessionId],
                    MAX([vd].[MaxTime]) AS [MaxTime]
                FROM
                    [dbo].[TopicSessions]
                    LEFT OUTER JOIN (SELECT
                                        [TopicSessionId],
                                        MAX([TimestampUTC]) AS [MaxTime]
                                     FROM
                                        [dbo].[VitalsData]
                                     GROUP BY
                                        [TopicSessionId]
                                    ) AS [vd] ON [vd].[TopicSessionId] = [Id]
                GROUP BY
                    [PatientSessionId]
               ) AS [tsmax] ON [PatientSessions].[Id] = [tsmax].[PatientSessionId]; 


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_PatientSessions';

