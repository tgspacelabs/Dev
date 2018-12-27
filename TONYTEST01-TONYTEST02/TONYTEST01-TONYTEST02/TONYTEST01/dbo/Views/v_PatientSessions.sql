

CREATE VIEW [dbo].[v_PatientSessions]
AS 
SELECT
    [PATIENT_ID]         = [LatestPatientSessionAssignment].[PatientId],
    [PATIENT_NAME]       = ISNULL([int_person].[last_nm], '') + ', ' + ISNULL([int_person].[first_nm], ''),
    [FIRST_NAME]			= [int_person].[first_nm],
    [MIDDLE_NAME]		= [int_person].[middle_nm],
    [LAST_NAME]			= [int_person].[last_nm],
    [MONITOR_NAME]       = 
    CASE WHEN [Assignment].[BedName] IS NULL OR [Assignment].[MonitorName] IS NULL THEN [Devices].[Name]
        ELSE RTRIM([Assignment].[BedName]) + '(' + RTRIM([Assignment].[Channel]) + ')'
    END,
    [UNIT_NAME]			= [Units].[organization_nm],
    [UNIT_CODE]			= [Units].[organization_cd],
    [UNIT_ID]			= [Units].[organization_id],
    [FACILITY_NAME]		= [Facilities].[organization_nm],
    [FACILITY_CODE]		= [Facilities].[organization_cd],
    [FACILITY_ID]		= [Facilities].[organization_id],
    [ACCOUNT_ID]         = [int_mrn_map].[mrn_xid2],
    [MRN_ID]             = [int_mrn_map].[mrn_xid],
    [DOB]                = [int_patient].[dob],
    [ADMIT_TIME_UTC]     = [PatientSessions].[BeginTimeUTC],
    [DISCHARGED_TIME_UTC]= [PatientSessions].[EndTimeUTC],
    [LAST_RESULT_UTC]    = tsmax.[MaxTime], 
    [PATIENT_MONITOR_ID] = [PatientSessions].[Id],
    [STATUS] = CASE WHEN [PatientSessions].[EndTimeUTC] IS NULL THEN 'A' ELSE 'D' END,
    [FACILITY_PARENT_ID] = [Facilities].[parent_organization_id],
    [ROOM] = [Devices].[Room],
    [BED] = [Assignment].[BedName],
    [SUBNET] = CAST(NULL AS NVARCHAR),
    [DeviceId] = DeviceSessions.DeviceId
FROM [dbo].[PatientSessions]

    -- From the patient session, get to the patient
    INNER JOIN
    (
    SELECT [PatientSessionId]
    ,[PatientId]
    FROM
    (
    SELECT [PatientSessionId]
        ,[PatientId]
        ,[R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
        FROM [dbo].[PatientSessionsMap]
    ) AS [PatientSessionsAssignmentSequence]
    WHERE [R]=1
    ) 
    AS [LatestPatientSessionAssignment]
    ON [LatestPatientSessionAssignment].[PatientSessionId] = [PatientSessions].[Id]

    -- From the patient session, get to the device and ID1
    INNER JOIN
    (
    SELECT [PatientSessionId]
        ,[DeviceSessionId]
    FROM
    (
    SELECT [PatientSessionId]
        ,[DeviceSessionId]
        ,[R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
        FROM [dbo].[PatientData]
    ) AS [PatientSessionsDeviceSequence]
    WHERE [R]=1
    ) 
    AS [LatestPatientSessionDevice]
        ON [LatestPatientSessionDevice].[PatientSessionId] = [PatientSessions].[Id]
    INNER JOIN [dbo].[DeviceSessions] 
        ON [DeviceSessions].[Id] = [LatestPatientSessionDevice].[DeviceSessionId]
    INNER JOIN [dbo].[Devices] 
        ON [DeviceSessions].[DeviceId] = [Devices].[Id]

    -- From the device, get to the facility and units
    INNER JOIN [dbo].[v_DeviceSessionAssignment] [Assignment] 
        ON [Assignment].[DeviceSessionId] = [LatestPatientSessionDevice].[DeviceSessionId]
    LEFT OUTER JOIN [dbo].[int_organization] AS [Facilities]
        ON [Facilities].[organization_nm] = [Assignment].[FacilityName]
            AND [Facilities].[category_cd]='F'
    LEFT OUTER JOIN [dbo].[int_organization] AS [Units]
        ON [Units].[organization_nm] = [Assignment].[UnitName] 
            AND [Units].[parent_organization_id] = [Facilities].[organization_id]

    LEFT OUTER JOIN [dbo].[int_mrn_map]
        ON [int_mrn_map].[patient_id] = [LatestPatientSessionAssignment].[PatientId] 
            AND [int_mrn_map].[merge_cd]='C'

    LEFT OUTER JOIN [dbo].[int_patient] 
        ON [int_patient].[patient_id] = [LatestPatientSessionAssignment].[PatientId]
    LEFT OUTER JOIN [dbo].[int_person] 
        ON [int_person].[person_id] = [LatestPatientSessionAssignment].[PatientId]

    INNER JOIN 
            (SELECT [PatientSessionId], MAX([MaxTime]) AS [MaxTime]
            FROM [dbo].[TopicSessions] 
                LEFT OUTER JOIN 
                    (SELECT [TopicSessionId], MAX([TimestampUTC]) AS [MaxTime]
                    FROM [dbo].[VitalsData] 
                    GROUP BY [TopicSessionId]
                    ) AS vd
                    ON vd.[TopicSessionId] = [TopicSessions].[Id]
            GROUP BY [PatientSessionId]
            ) AS tsmax
        ON [PatientSessions].[Id] = tsmax.[PatientSessionId] 
