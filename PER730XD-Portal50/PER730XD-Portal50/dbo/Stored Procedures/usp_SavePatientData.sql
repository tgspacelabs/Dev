

CREATE PROCEDURE [dbo].[usp_SavePatientData]
    (@patientData [dbo].[PatientDataType] READONLY)
AS
BEGIN
    
    SET NOCOUNT ON
    
    INSERT INTO [dbo].[PatientData]
    (
        [Id],
        [PatientSessionId],
        [DeviceSessionId],
        [LastName],
        [MiddleName],
        [FirstName],
        [FullName],
        [Gender],
        [ID1],
        [ID2],
        [DOB],
        [Weight],
        [WeightUOM],
        [Height],
        [HeightUOM],
        [BSA],
        [Location],
        [PatientType],
        [TimestampUTC]
    )

    SELECT
        [d].[Id],
        [d].[PatientSessionId],
        [d].[DeviceSessionId],
        [d].[LastName],
        [d].[MiddleName],
        [d].[FirstName],
        [d].[FullName],
        [d].[Gender],
        [d].[ID1],
        [d].[ID2],
        [d].[DOB],
        [d].[Weight],
        [d].[WeightUOM],
        [d].[Height],
        [d].[HeightUOM],
        [d].[BSA],
        [d].[Location],
        [d].[PatientType],
        [d].[TimestampUTC]
        
    FROM @patientData AS [d]

    SELECT [PatientSessionId] = [LatestPatientData].[PatientSessionId]
          ,[FacilityId] = ISNULL([int_mrn_map].[organization_id], [int_organization].[organization_id])
          ,[PatientId] = ISNULL([int_mrn_map].[patient_id], ISNULL([LatestPatientSessionsMap].[PatientId], NEWID()))
          ,[ID1]
          ,[ID2]
          ,[FirstName]
          ,[MiddleName]
          ,[LastName]
          ,[DOB]
          ,[GenderCodeId] = [int_misc_code].[code_id]
        INTO #newData
        FROM
        (
            SELECT [PatientSessionId]
                  ,[DeviceSessionId]
                  ,[FirstName]
                  ,[MiddleName]
                  ,[LastName]
                  ,[Gender]
                  ,[ID1]
                  ,[ID2]
                  ,[DOB]
                FROM
                (
                    SELECT [PatientSessionId] 
                          ,[DeviceSessionId]
                          ,[LastName]
                          ,[MiddleName]
                          ,[FirstName]
                          ,[Gender]
                          ,[ID1]
                          ,[ID2]
                          ,[DOB]
                          ,[R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
                        FROM @patientData
                ) AS [PatientDataSequence]
                WHERE [R]=1 AND [ID1] IS NOT NULL
        ) AS [LatestPatientData]
        LEFT OUTER JOIN
        (
            SELECT [DeviceSessionId]
                  ,[FacilityValue] =
                    CASE
                        WHEN CHARINDEX('+', [Value]) > 0 THEN LEFT([Value], CHARINDEX('+', [Value]) - 1)
                        ELSE NULL
                    END
                FROM
                (
                    SELECT [DeviceSessionId]
                          ,[Value]
                          ,[R] = ROW_NUMBER() OVER (PARTITION BY [DeviceSessionId] ORDER BY [TimestampUTC] DESC)
                        FROM [dbo].[DeviceInfoData]
                        WHERE [Name]='Unit'
                ) AS [DeviceSessionFacilitySequence]
                WHERE [R]=1
        ) AS [LatestDeviceSessionFacility]
            ON [LatestDeviceSessionFacility].[DeviceSessionId]=[LatestPatientData].[DeviceSessionId]
        LEFT OUTER JOIN [dbo].[int_organization]
            ON [organization_nm]=[LatestDeviceSessionFacility].[FacilityValue] AND [category_cd]='F'
        LEFT OUTER JOIN
        (
            SELECT [PatientSessionId]
                  ,[PatientId]
                FROM
                (
                    SELECT [PatientSessionId]
                          ,[PatientId]
                          ,[R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                        FROM [dbo].[PatientSessionsMap]
                ) AS [PatientSessionsMapSequence]
                WHERE [R]=1
        ) AS [LatestPatientSessionsMap]
            ON [LatestPatientSessionsMap].[PatientSessionId]=[LatestPatientData].[PatientSessionId]
        LEFT OUTER JOIN [dbo].[int_misc_code]
            ON [int_misc_code].[category_cd]='SEX' and [int_misc_code].[short_dsc]=[LatestPatientData].[Gender]
        LEFT OUTER JOIN [dbo].[int_mrn_map]
            ON [int_mrn_map].[mrn_xid]=[ID1]
        WHERE LTRIM(RTRIM(ISNULL([ID1],''))) <> ''

    INSERT INTO [dbo].[PatientSessionsMap]([PatientSessionId], [PatientId])
    SELECT [Src].[PatientSessionId]
          ,[Src].[PatientId]
        FROM #newData AS [Src]
        LEFT OUTER JOIN
        (
            SELECT [PatientSessionId]
                  ,[PatientId]
                  ,[R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                FROM [dbo].[PatientSessionsMap]
        ) AS [PatientSessionsMapSequence]
            ON [PatientSessionsMapSequence].[R]=1
            AND [PatientSessionsMapSequence].[PatientSessionId] = [Src].[PatientSessionId]
            AND [PatientSessionsMapSequence].[PatientId] = [Src].[PatientId]
        WHERE [PatientSessionsMapSequence].[PatientSessionId] IS NULL

    MERGE
        INTO [dbo].[int_mrn_map] AS [Dest]
        USING #newData AS [Src]
        ON [Src].[PatientId] = [Dest].[patient_id]
        WHEN NOT MATCHED BY TARGET AND [Src].[FacilityId] IS NOT NULL
            THEN INSERT ([organization_id], [mrn_xid], [patient_id], [merge_cd], [mrn_xid2])
                VALUES ([Src].[FacilityId], [Src].[ID1], [Src].[PatientId], 'C', [Src].[ID2])
        WHEN MATCHED 
            THEN UPDATE SET [mrn_xid2]=ISNULL(NULLIF([Src].[ID2], ''), [Dest].[mrn_xid2]),
                            [mrn_xid]=[Src].[ID1]
    ;

    MERGE
        INTO [dbo].[int_patient] AS [Dest]
        USING #newData AS [Src]
        ON [Dest].[patient_id]=[Src].[PatientId]
        WHEN NOT MATCHED BY TARGET
            THEN INSERT ([patient_id], [dob], [gender_cid])
                VALUES ([Src].[PatientId], [Src].[DOB], [Src].[GenderCodeId])
        WHEN MATCHED
            THEN UPDATE SET [dob]=ISNULL([Src].[DOB], [Dest].[dob])
                           ,[gender_cid]=ISNULL([Src].[GenderCodeId], [Dest].[gender_cid])
    ;

    MERGE
        INTO [dbo].[int_person] AS [Dest]
        USING #newData AS [Src]
        ON [Dest].[person_id]=[Src].[PatientId]
        WHEN NOT MATCHED BY TARGET
            THEN INSERT ([person_id], [first_nm], [middle_nm], [last_nm])
                VALUES ([Src].[PatientId], [Src].[FirstName], [Src].[MiddleName], [Src].[LastName])
        WHEN MATCHED
            THEN UPDATE SET [first_nm]=ISNULL(NULLIF([Src].[FirstName], ''), [Dest].[first_nm])
                           ,[middle_nm]=ISNULL(NULLIF([Src].[MiddleName], ''), [Dest].[middle_nm])
                           ,[last_nm]=ISNULL(NULLIF([Src].[LastName], ''), [Dest].[last_nm])
    ;

END




