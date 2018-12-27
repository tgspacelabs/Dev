CREATE VIEW [dbo].[v_PatientSessions]
AS 
SELECT
    [PATIENT_ID]         = lpsa.[PatientId],
    [PATIENT_NAME]       = ISNULL(person.[last_nm], '') + ', ' + ISNULL(person.[first_nm], ''),
    [FIRST_NAME]			= person.[first_nm],
    [MIDDLE_NAME]		= person.[middle_nm],
    [LAST_NAME]			= person.[last_nm],
    [MONITOR_NAME]       = 
        CASE 
            WHEN dsa.[BedName] IS NULL OR dsa.[MonitorName] IS NULL THEN d.[Name]
            ELSE RTRIM(dsa.[BedName]) + '(' + RTRIM(dsa.[Channel]) + ')'
        END,
    [UNIT_NAME]			= units.[organization_nm],
    [UNIT_CODE]			= units.[organization_cd],
    [UNIT_ID]			= units.[organization_id],
    [FACILITY_NAME]		= fac.[organization_nm],
    [FACILITY_CODE]		= fac.[organization_cd],
    [FACILITY_ID]		= fac.[organization_id],
    [ACCOUNT_ID]         = imm.[mrn_xid2],
    [MRN_ID]             = imm.[mrn_xid],
    [DOB]                = ip.[dob],
    [ADMIT_TIME_UTC]     = ps.[BeginTimeUTC],
    [DISCHARGED_TIME_UTC]= ps.[EndTimeUTC],
    [LAST_RESULT_UTC]    = tsmax.[MaxTime], 
    [PATIENT_MONITOR_ID] = ps.[Id],
    [STATUS] = 
        CASE 
            WHEN ps.[EndTimeUTC] IS NULL THEN 'A' 
            ELSE 'D' 
        END,
    [FACILITY_PARENT_ID] = fac.[parent_organization_id],
    [ROOM] = d.[Room],
    [BED] = dsa.[BedName],
    [SUBNET] = CAST(NULL AS NVARCHAR),
    [DeviceId] = ds.DeviceId
FROM [dbo].[PatientSessions] AS ps

    -- From the patient session, get to the patient
    INNER JOIN
    (
    SELECT [PatientSessionsAssignmentSequence].[PatientSessionId]
    ,[PatientSessionsAssignmentSequence].[PatientId]
    FROM
    (
    SELECT [dbo].[PatientSessionsMap].[PatientSessionId]
        ,[dbo].[PatientSessionsMap].[PatientId]
        ,[R] = ROW_NUMBER() OVER (PARTITION BY [dbo].[PatientSessionsMap].[PatientSessionId] ORDER BY [dbo].[PatientSessionsMap].[Sequence] DESC)
        FROM [dbo].[PatientSessionsMap]
    ) AS [PatientSessionsAssignmentSequence]
    WHERE [PatientSessionsAssignmentSequence].[R]=1
    ) 
    AS lpsa -- LatestPatientSessionAssignment
    ON lpsa.[PatientSessionId] = ps.[Id]

    -- From the patient session, get to the device and ID1
    INNER JOIN
    (
    SELECT psds.[PatientSessionId]
        ,psds.[DeviceSessionId]
    FROM
    (
    SELECT [dbo].pd.[PatientSessionId]
        ,[dbo].pd.[DeviceSessionId]
        ,[R] = ROW_NUMBER() OVER (PARTITION BY [dbo].pd.[PatientSessionId] ORDER BY [dbo].pd.[TimestampUTC] DESC)
        FROM [dbo].[PatientData] AS pd
    ) AS psds --PatientSessionsDeviceSequence
    WHERE psds.[R]=1
    ) 
    AS lpsd --LatestPatientSessionDevice
        ON lpsd.[PatientSessionId] = ps.[Id]
    INNER JOIN [dbo].[DeviceSessions] AS ds
        ON ds.[Id] = lpsd.[DeviceSessionId]
    INNER JOIN [dbo].[Devices] AS d
        ON ds.[DeviceId] = d.[Id]

    -- From the device, get to the facility and units
    INNER JOIN [dbo].[v_DeviceSessionAssignment] AS dsa 
        ON dsa.[DeviceSessionId] = lpsd.[DeviceSessionId]
    LEFT OUTER JOIN [dbo].[int_organization] AS fac
        ON fac.[organization_nm] = dsa.[FacilityName]
            AND fac.[category_cd]='F'
    LEFT OUTER JOIN [dbo].[int_organization] AS units
        ON units.[organization_nm] = dsa.[UnitName] 
            AND units.[parent_organization_id] = fac.[organization_id]

    LEFT OUTER JOIN [dbo].[int_mrn_map] AS imm
        ON imm.[patient_id] = lpsa.[PatientId] 
            AND imm.[merge_cd]='C'

    LEFT OUTER JOIN [dbo].[int_patient] AS ip
        ON ip.[patient_id] = lpsa.[PatientId]
    LEFT OUTER JOIN [dbo].[int_person] AS person
        ON person.[person_id] = lpsa.[PatientId]

    INNER JOIN 
            (SELECT ts.[PatientSessionId], MAX(vd.[MaxTime]) AS [MaxTime]
            FROM [dbo].[TopicSessions] AS ts 
                LEFT OUTER JOIN 
                    (SELECT vd1.[TopicSessionId], MAX(vd1.[TimestampUTC]) AS [MaxTime]
                    FROM [dbo].[VitalsData] AS vd1
                    GROUP BY vd1.[TopicSessionId]
                    ) AS vd
                    ON vd.[TopicSessionId] = ts.[Id]
            GROUP BY ts.[PatientSessionId]
            ) AS tsmax
        ON ps.[Id] = tsmax.[PatientSessionId] 
