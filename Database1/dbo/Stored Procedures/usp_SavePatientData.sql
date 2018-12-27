


CREATE PROCEDURE [dbo].[usp_SavePatientData]
    (
     @patientData [dbo].[PatientDataType] READONLY
    )
AS
BEGIN	
    SET NOCOUNT ON;
	
    INSERT  INTO [dbo].[PatientData]
            ([Id],
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
    FROM
        @patientData AS [d];

	/* Register the binding with the patient sessions */
    INSERT  INTO [dbo].[PatientSessionsMap]
            ([PatientSessionId],
             [PatientId]
            )
    SELECT
        [Src].[PatientSessionId],
        [Src].[PatientId]
    FROM
        (SELECT
            [PatientSessionId] = [LatestPatientData].[PatientSessionId],
            [PatientId] = COALESCE([patient_id], [PatientSessionsMapSequence].[PatientId], NEWID())
         FROM
            /* The new data coming in */
            (SELECT
                [PatientDataSequence].[PatientSessionId],
                [PatientDataSequence].[ID1]
             FROM
                (SELECT
                    [PatientSessionId],
                    [ID1],
                    [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
                 FROM
                    @patientData
                ) AS [PatientDataSequence]
             WHERE
                [PatientDataSequence].[R] = 1
            ) AS [LatestPatientData] /* The patientId that's already associated with existing patient sessions */
            LEFT OUTER JOIN (SELECT
                                [PatientSessionId],
                                [PatientId],
                                [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                             FROM
                                [dbo].[PatientSessionsMap]
                            ) AS [PatientSessionsMapSequence] ON [PatientSessionsMapSequence].[R] = 1
                                                                 AND [PatientSessionsMapSequence].[PatientSessionId] = [LatestPatientData].[PatientSessionId]
					/* The patientId that's associated with the incoming ID1 */
            LEFT OUTER JOIN [dbo].[int_mrn_map] ON [mrn_xid] = [LatestPatientData].[ID1]
        ) AS [Src] /* Do not insert a new row when we are not updating the current binding */
        LEFT OUTER JOIN (SELECT
                            [PatientSessionId],
                            [PatientId],
                            [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                         FROM
                            [dbo].[PatientSessionsMap]
                        ) AS [PatientSessionsMapSequence] ON [PatientSessionsMapSequence].[R] = 1
                                                             AND [PatientSessionsMapSequence].[PatientSessionId] = [Src].[PatientSessionId]
                                                             AND [PatientSessionsMapSequence].[PatientId] = [Src].[PatientId]
    WHERE
        [PatientSessionsMapSequence].[PatientSessionId] IS NULL;

	/* update the mrn_map when we have the device org assignments */
    MERGE INTO [dbo].[int_mrn_map] AS [Dest]
    USING
        (SELECT
            [FacilityId] = [organization_id],
            [PatientId] = [LatestPatientSessionsMap].[PatientId],
            [LatestPatientData].[ID1],
            [LatestPatientData].[ID2]
         FROM
            (SELECT
                [PatientDataSequence].[PatientSessionId],
                [PatientDataSequence].[DeviceSessionId],
                [PatientDataSequence].[ID1],
                [PatientDataSequence].[ID2]
             FROM
                (SELECT
                    [PatientSessionId],
                    [DeviceSessionId],
                    [ID1],
                    [ID2],
                    [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
                 FROM
                    @patientData
                ) AS [PatientDataSequence]
             WHERE
                [PatientDataSequence].[R] = 1
                AND LTRIM(RTRIM(ISNULL([PatientDataSequence].[ID1], ''))) <> ''
            ) AS [LatestPatientData]
            INNER JOIN (SELECT
                            [DeviceSessionFacilitySequence].[DeviceSessionId],
                            [FacilityValue] = CASE WHEN CHARINDEX('+', [DeviceSessionFacilitySequence].[Value]) > 0 THEN LEFT([DeviceSessionFacilitySequence].[Value], CHARINDEX('+', [DeviceSessionFacilitySequence].[Value]) - 1)
                                                   ELSE NULL
                                              END
                        FROM
                            (SELECT
                                [DeviceSessionId],
                                [Value],
                                [R] = ROW_NUMBER() OVER (PARTITION BY [DeviceSessionId] ORDER BY [TimestampUTC] DESC)
                             FROM
                                [dbo].[DeviceInfoData]
                             WHERE
                                [Name] = 'Unit'
                            ) AS [DeviceSessionFacilitySequence]
                        WHERE
                            [DeviceSessionFacilitySequence].[R] = 1
                       ) AS [LatestDeviceSessionFacility] ON [LatestDeviceSessionFacility].[DeviceSessionId] = [LatestPatientData].[DeviceSessionId]
            INNER JOIN [dbo].[int_organization] ON [organization_nm] = [LatestDeviceSessionFacility].[FacilityValue]
                                                   AND [category_cd] = 'F'
            LEFT OUTER JOIN (SELECT
                                [PatientSessionsMapSequence].[PatientSessionId],
                                [PatientSessionsMapSequence].[PatientId]
                             FROM
                                (SELECT
                                    [PatientSessionId],
                                    [PatientId],
                                    [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                                 FROM
                                    [dbo].[PatientSessionsMap]
                                ) AS [PatientSessionsMapSequence]
                             WHERE
                                [PatientSessionsMapSequence].[R] = 1
                            ) AS [LatestPatientSessionsMap] ON [LatestPatientSessionsMap].[PatientSessionId] = [LatestPatientData].[PatientSessionId]
        ) AS [Src]
    ON [Src].[PatientId] = [Dest].[patient_id]
    WHEN NOT MATCHED BY TARGET THEN
        INSERT
               ([organization_id],
                [mrn_xid],
                [patient_id],
                [merge_cd],
                [mrn_xid2]
               )
        VALUES ([Src].[FacilityId],
                [Src].[ID1],
                [Src].[PatientId],
                'C',
                [Src].[ID2]
               )
    WHEN MATCHED THEN
        UPDATE SET
               [Dest].[mrn_xid2] = ISNULL(NULLIF([Src].[ID2], ''), [Dest].[mrn_xid2]),
               [Dest].[mrn_xid] = [Src].[ID1];

	/* update int_patient.  we do this even if we don't have the mrn_map record */
    MERGE INTO [dbo].[int_patient] AS [Dest]
    USING
        (SELECT
            [LatestPatientSessionsMap].[PatientId],
            [LatestPatientData].[DOB],
            [GenderCodeId] = [code_id]
         FROM
            (SELECT
                [PatientDataSequence].[PatientSessionId],
                [PatientDataSequence].[ID1],
                [PatientDataSequence].[Gender],
                [PatientDataSequence].[DOB]
             FROM
                (SELECT
                    [PatientSessionId],
                    [ID1],
                    [Gender],
                    [DOB],
                    [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
                 FROM
                    @patientData
                ) AS [PatientDataSequence]
             WHERE
                [PatientDataSequence].[R] = 1
                AND [PatientDataSequence].[ID1] IS NOT NULL
            ) AS [LatestPatientData]
            INNER JOIN (SELECT
                            [PatientSessionsMapSequence].[PatientSessionId],
                            [PatientSessionsMapSequence].[PatientId]
                        FROM
                            (SELECT
                                [PatientSessionId],
                                [PatientId],
                                [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                             FROM
                                [dbo].[PatientSessionsMap]
                            ) AS [PatientSessionsMapSequence]
                        WHERE
                            [PatientSessionsMapSequence].[R] = 1
                       ) AS [LatestPatientSessionsMap] ON [LatestPatientSessionsMap].[PatientSessionId] = [LatestPatientData].[PatientSessionId]
            LEFT OUTER JOIN [dbo].[int_misc_code] ON [category_cd] = 'SEX'
                                                     AND [short_dsc] = [LatestPatientData].[Gender]
        ) AS [Src]
    ON [Dest].[patient_id] = [Src].[PatientId]
    WHEN NOT MATCHED BY TARGET THEN
        INSERT
               ([patient_id],
                [dob],
                [gender_cid]
               )
        VALUES ([Src].[PatientId],
                [Src].[DOB],
                [Src].[GenderCodeId]
               )
    WHEN MATCHED THEN
        UPDATE SET
               [Dest].[dob] = ISNULL([Src].[DOB], [Dest].[dob]),
               [Dest].[gender_cid] = ISNULL([Src].[GenderCodeId], [Dest].[gender_cid]);

	/* update int_person.  we do this even if we don't have the mrn_map record */
    MERGE INTO [dbo].[int_person] AS [Dest]
    USING
        (SELECT
            [LatestPatientSessionsMap].[PatientId],
            [LatestPatientData].[FirstName],
            [LatestPatientData].[MiddleName],
            [LatestPatientData].[LastName]
         FROM
            (SELECT
                [PatientDataSequence].[PatientSessionId],
                [PatientDataSequence].[ID1],
                [PatientDataSequence].[FirstName],
                [PatientDataSequence].[MiddleName],
                [PatientDataSequence].[LastName]
             FROM
                (SELECT
                    [PatientSessionId],
                    [ID1],
                    [FirstName],
                    [MiddleName],
                    [LastName],
                    [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
                 FROM
                    @patientData
                ) AS [PatientDataSequence]
             WHERE
                [PatientDataSequence].[R] = 1
                AND [PatientDataSequence].[ID1] IS NOT NULL
            ) AS [LatestPatientData]
            INNER JOIN (SELECT
                            [PatientSessionsMapSequence].[PatientSessionId],
                            [PatientSessionsMapSequence].[PatientId]
                        FROM
                            (SELECT
                                [PatientSessionId],
                                [PatientId],
                                [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                             FROM
                                [dbo].[PatientSessionsMap]
                            ) AS [PatientSessionsMapSequence]
                        WHERE
                            [PatientSessionsMapSequence].[R] = 1
                       ) AS [LatestPatientSessionsMap] ON [LatestPatientSessionsMap].[PatientSessionId] = [LatestPatientData].[PatientSessionId]
        ) AS [Src]
    ON [Dest].[person_id] = [Src].[PatientId]
    WHEN NOT MATCHED BY TARGET THEN
        INSERT
               ([person_id],
                [first_nm],
                [middle_nm],
                [last_nm]
               )
        VALUES ([Src].[PatientId],
                [Src].[FirstName],
                [Src].[MiddleName],
                [Src].[LastName]
               )
    WHEN MATCHED THEN
        UPDATE SET
               [Dest].[first_nm] = ISNULL(NULLIF([Src].[FirstName], ''), [Dest].[first_nm]),
               [Dest].[middle_nm] = ISNULL(NULLIF([Src].[MiddleName], ''), [Dest].[middle_nm]),
               [Dest].[last_nm] = ISNULL(NULLIF([Src].[LastName], ''), [Dest].[last_nm]);

END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_SavePatientData';

