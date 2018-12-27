

CREATE PROCEDURE [dbo].[usp_SaveDeviceInfoDataSet]
    (
     @deviceInfoData [dbo].[DeviceInfoDataSetType] READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[DeviceInfoData]
            ([Id],
             [DeviceSessionId],
             [Name],
             [Value],
             [TimestampUTC]
            )
    SELECT
        [Id],
        [DeviceSessionId],
        [Name],
        [Value],
        [TimeStampUTC]
    FROM
        @deviceInfoData;
	
	/* If a patient admit was pending on the device org assignment arrival, then we
	   create the mrn_map row here.  The patient id might be already bound to the
	   patient session or not */
    MERGE INTO [dbo].[int_mrn_map] AS [Dest]
    USING
        (SELECT
            [PatientId] = ISNULL([PatientSessionsMapSequence].[PatientId], NEWID()),
            [FacilityId] = [Facilities].[organization_id],
            [ID1] = [LatestPatientData].[ID1],
            [ID2] = [LatestPatientData].[ID2]
         FROM
            (SELECT
                [DeviceSessionFacilitySequence].[DeviceSessionId],
                [FacilityValue] = CASE WHEN CHARINDEX('+', [DeviceSessionFacilitySequence].[Value]) > 0 THEN LEFT([DeviceSessionFacilitySequence].[Value], CHARINDEX('+', [DeviceSessionFacilitySequence].[Value]) - 1)
                                       ELSE NULL
                                  END
             FROM
                (SELECT
                    [DeviceSessionId],
                    [Value],
                    [R] = ROW_NUMBER() OVER (PARTITION BY [DeviceSessionId] ORDER BY [TimeStampUTC] DESC)
                 FROM
                    @deviceInfoData
                 WHERE
                    [Name] = 'Unit'
                ) AS [DeviceSessionFacilitySequence]
             WHERE
                [DeviceSessionFacilitySequence].[R] = 1
            ) AS [LatestDeviceSessionFacility]
            INNER JOIN [dbo].[int_organization] AS [Facilities] ON [Facilities].[category_cd] = 'F'
                                                                   AND [Facilities].[organization_nm] = [LatestDeviceSessionFacility].[FacilityValue]
            INNER JOIN (SELECT
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
                                [dbo].[PatientData]
                            ) AS [PatientDataSequence]
                        WHERE
                            [PatientDataSequence].[R] = 1
                            AND [PatientDataSequence].[ID1] IS NOT NULL
                       ) AS [LatestPatientData] ON [LatestPatientData].[DeviceSessionId] = [LatestDeviceSessionFacility].[DeviceSessionId]
            INNER JOIN (SELECT
                            [PatientSessionId],
                            [PatientId],
                            [R] = ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC)
                        FROM
                            [dbo].[PatientSessionsMap]
                       ) AS [PatientSessionsMapSequence] ON [PatientSessionsMapSequence].[R] = 1
                                                            AND [PatientSessionsMapSequence].[PatientSessionId] = [LatestPatientData].[PatientSessionId]
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
               );
						
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_SaveDeviceInfoDataSet';

