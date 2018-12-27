CREATE PROCEDURE [dbo].[usp_GetPatientInformation]
    (@deviceIds [dbo].[GetPatientUpdateInformationType] READONLY)
AS
BEGIN

    SET NOCOUNT ON;

    /*
        This gives the currently known PatientSession - Device association for all ACTIVE devices
    */
    WITH [PatientSessionActiveDevice] ([PatientSessionId], [DeviceId], [ID1], [MonitoringStatus])
    AS (SELECT
            [pd].[PatientSessionId],
            [ds].[DeviceId],
            [imm].[mrn_xid] AS [ID1],
            [MonitoringStatusSequence].[MonitoringStatus]
        FROM [dbo].[PatientData] AS [pd]
            INNER JOIN (SELECT
                            [pd2].[PatientSessionId],
                            MAX([pd2].[TimestampUTC]) AS [MaxTimestampUTC]
                        FROM [dbo].[PatientData] AS [pd2]
                        GROUP BY [pd2].[PatientSessionId]) AS [PatientSessionMaxTimestampUTC]
                ON [pd].[PatientSessionId] = [PatientSessionMaxTimestampUTC].[PatientSessionId]
                   AND [pd].[TimestampUTC] = [PatientSessionMaxTimestampUTC].[MaxTimestampUTC]
            INNER JOIN [dbo].[DeviceSessions] AS [ds]
                ON [ds].[Id] = [pd].[DeviceSessionId]
                   AND [ds].[EndTimeUTC] IS NULL
            LEFT OUTER JOIN (SELECT
                                 [DeviceInfoSequence].[DeviceSessionId],
                                 [DeviceInfoSequence].[Value] AS [MonitoringStatus],
                                 ROW_NUMBER() OVER (PARTITION BY
                                                        [DeviceInfoSequence].[DeviceSessionId],
                                                        [DeviceInfoSequence].[Name]
                                                    ORDER BY [DeviceInfoSequence].[TimestampUTC] DESC) AS [RowNumber]
                             FROM [dbo].[DeviceInfoData] AS [DeviceInfoSequence]
                             WHERE [DeviceInfoSequence].[Name] = N'MonitoringStatus') AS [MonitoringStatusSequence]
                ON [MonitoringStatusSequence].[DeviceSessionId] = [ds].[Id]
                   AND [MonitoringStatusSequence].[RowNumber] = 1
            INNER JOIN (SELECT
                            [PatientSessionsMapSequence].[PatientSessionId],
                            [PatientSessionsMapSequence].[PatientId]
                        FROM (SELECT
                                  [psm].[PatientSessionId],
                                  [psm].[PatientId],
                                  ROW_NUMBER() OVER (PARTITION BY [psm].[PatientSessionId]
                                                     ORDER BY [psm].[Sequence] DESC) AS [RowNumber]
                              FROM [dbo].[PatientSessionsMap] AS [psm]) AS [PatientSessionsMapSequence]
                        WHERE [PatientSessionsMapSequence].[RowNumber] = 1) AS [LatestPatientSessionsMap]
                ON [LatestPatientSessionsMap].[PatientSessionId] = [pd].[PatientSessionId]
            INNER JOIN [dbo].[int_mrn_map] AS [imm]
                ON [imm].[patient_id] = [LatestPatientSessionsMap].[PatientId]
                   AND [imm].[merge_cd] = 'C')
    SELECT DISTINCT
           [Ids].[PatientSessionId],
           [Ids].[DeviceId],
           CASE
               WHEN ([psad].[DeviceId] IS NULL
                     OR [psad].[MonitoringStatus] = N'Standby')
                    AND ([ipm].[monitor_id] IS NULL
                         OR [im].[standby] IS NOT NULL)
                   THEN
                   [imm].[mrn_xid]
               ELSE
                   [dbo].[fnMarkIdAsDuplicate]([imm].[mrn_xid])
           END AS [ID1],
           [imm].[mrn_xid2] AS [ID2],
           [iper].[first_nm] AS [FirstName],
           [iper].[middle_nm] AS [MiddleName],
           [iper].[last_nm] AS [LastName],
           CASE [gender_code].[code]
               WHEN 'M'
                   THEN
                   'Male'
               WHEN 'F'
                   THEN
                   'Female'
               ELSE
                   NULL
           END AS [Gender],
           CONVERT(VARCHAR(30), [ipat].[dob], 126) AS [DOB],
           CAST([ipat].[bsa] AS VARCHAR(30)) AS [BSA]
    FROM @deviceIds AS [Ids]
        --
        -- The demographics currently recorded for the ID1
        --
        INNER JOIN [dbo].[int_mrn_map] AS [imm]
            ON [imm].[mrn_xid] = [Ids].[ID1]
               AND [imm].[merge_cd] = 'C'
        LEFT OUTER JOIN [dbo].[int_patient] AS [ipat]
            ON [ipat].[patient_id] = [imm].[patient_id]
        LEFT OUTER JOIN [dbo].[int_person] AS [iper]
            ON [iper].[person_id] = [imm].[patient_id]
        LEFT OUTER JOIN [dbo].[int_misc_code] AS [gender_code]
            ON [gender_code].[code_id] = [ipat].[gender_cid]
        --
        -- The Dataloader devices that are active on the same ID1
        -- For each of these also look up the current PatientSessionId so that discovering a different device
        -- with the same patient session (edit ET channel for example) doesn't yield a duplicate.
        --
        LEFT OUTER JOIN [PatientSessionActiveDevice] AS [psad]
            ON [psad].[ID1] = [Ids].[ID1]
               AND [psad].[DeviceId] <> [Ids].[DeviceId]
               AND [psad].[PatientSessionId] <> [Ids].[PatientSessionId]
        --
        -- The Legacy devices that are active on the same ID1
        --
        LEFT OUTER JOIN [dbo].[int_patient_monitor] AS [ipm]
            ON [ipm].[patient_id] = [imm].[patient_id]
               AND [ipm].[active_sw] = '1'
        LEFT OUTER JOIN [dbo].[int_monitor] AS [im]
            ON [im].[monitor_id] = [ipm].[monitor_id];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get basic patient information for a list of devices.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetPatientInformation';

