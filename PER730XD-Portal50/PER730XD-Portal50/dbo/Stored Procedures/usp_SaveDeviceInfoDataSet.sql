
CREATE PROCEDURE [dbo].[usp_SaveDeviceInfoDataSet]
    (@deviceInfoData [dbo].[DeviceInfoDataSetType] READONLY)
AS
BEGIN

    SET NOCOUNT ON

    INSERT INTO [dbo].[DeviceInfoData] ([Id], [DeviceSessionId], [Name], [Value], [TimestampUTC])
        SELECT [Id], [DeviceSessionId], [Name], [Value], [TimestampUTC]
            FROM @deviceInfoData
    
    SELECT [PatientId] = [LatestPatientSessionsMap].[PatientId]
          ,[FacilityId] = [Facilities].[organization_id]
          ,[ID1] = [LatestPatientData].[ID1]
          ,[ID2] = [LatestPatientData].[ID2]
        INTO #newPatients
        FROM
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
                        FROM @deviceInfoData
                        WHERE [Name]='Unit'
                ) AS [DeviceSessionFacilitySequence]
                WHERE [R]=1
        ) AS [LatestDeviceSessionFacility]
        INNER JOIN [dbo].[int_organization] AS [Facilities]
            ON [category_cd]='F' AND [organization_nm]=[LatestDeviceSessionFacility].[FacilityValue]
        INNER JOIN
        (
            SELECT [PatientSessionId] 
                  ,[DeviceSessionId]
                  ,[ID1]
                  ,[ID2]
                FROM
                (
                    SELECT [PatientSessionId] 
                          ,[DeviceSessionId]
                          ,[ID1]
                          ,[ID2]
                          ,[R]=ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [TimestampUTC] DESC)
                        FROM [dbo].[PatientData]
                ) AS [PatientDataSequence]
                WHERE [R]=1 AND [ID1] IS NOT NULL
        ) AS [LatestPatientData]
            ON [LatestPatientData].[DeviceSessionId]=[LatestDeviceSessionFacility].[DeviceSessionId]
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
                ) AS [PatientSessionsMapSequence]
                WHERE [R]=1
        ) AS [LatestPatientSessionsMap]
            ON [LatestPatientSessionsMap].[PatientSessionId]=[LatestPatientData].[PatientSessionId]
        LEFT OUTER JOIN [dbo].[int_mrn_map]
            ON [int_mrn_map].[organization_id]=[Facilities].[organization_id]
            AND [int_mrn_map].[mrn_xid]=[LatestPatientData].[ID1]

        MERGE
            INTO [dbo].[int_mrn_map] AS [Dest]
            USING #newPatients AS [Src]
            ON [Src].[PatientId] = [Dest].[patient_id]
            WHEN NOT MATCHED BY TARGET AND [Src].[FacilityId] IS NOT NULL
                THEN INSERT ([organization_id], [mrn_xid], [patient_id], [merge_cd], [mrn_xid2])
                    VALUES ([Src].[FacilityId], [Src].[ID1], [Src].[PatientId], 'C', [Src].[ID2]);
                        
END



