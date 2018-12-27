CREATE VIEW [dbo].[v_DeviceSessionAssignment]
WITH
     SCHEMABINDING
AS
SELECT
    [Id] AS [DeviceSessionId],
    -- The only case implemented here is the case of ETR, which provides in the device info, the key "Unit" with a value in the form "FacilityName+UnitName".
    CASE WHEN CHARINDEX(N'+', [InfoUnit].[Value]) > 0 THEN LEFT([InfoUnit].[Value], CHARINDEX(N'+', [InfoUnit].[Value]) - 1)
         ELSE NULL
    END AS [FacilityName],
    CASE WHEN CHARINDEX(N'+', [InfoUnit].[Value]) > 0 THEN SUBSTRING([InfoUnit].[Value], CHARINDEX(N'+', [InfoUnit].[Value]) + 1, LEN([InfoUnit].[Value]))
         ELSE NULL
    END AS [UnitName],
    [InfoBed].[Value] AS [BedName],
    [InfoDeviceName].[Value] AS [MonitorName],
    [InfoTransmitter].[Value] AS [Channel]
FROM
    [dbo].[DeviceSessions]
    OUTER APPLY (SELECT
                    [LatestDeviceInfo].[Value]
                 FROM
                    (SELECT
                        [did].[Value],
                        [R] = ROW_NUMBER() OVER (PARTITION BY [did].[DeviceSessionId] ORDER BY [did].[TimestampUTC] DESC)
                     FROM
                        [dbo].[DeviceInfoData] AS [did]
                     WHERE
                        [did].[DeviceSessionId] = [DeviceSessions].[Id]
                        AND [did].[Name] = N'Bed'
                    ) AS [LatestDeviceInfo]
                 WHERE
                    [LatestDeviceInfo].[R] = 1
                ) AS [InfoBed]
    OUTER APPLY (SELECT
                    [LatestDeviceInfo].[Value]
                 FROM
                    (SELECT
                        [did].[Value],
                        [R] = ROW_NUMBER() OVER (PARTITION BY [did].[DeviceSessionId] ORDER BY [did].[TimestampUTC] DESC)
                     FROM
                        [dbo].[DeviceInfoData] AS [did]
                     WHERE
                        [did].[DeviceSessionId] = [DeviceSessions].[Id]
                        AND [did].[Name] = N'DeviceName'
                    ) AS [LatestDeviceInfo]
                 WHERE
                    [LatestDeviceInfo].[R] = 1
                ) AS [InfoDeviceName]
    OUTER APPLY (SELECT
                    [LatestDeviceInfo].[Value]
                 FROM
                    (SELECT
                        [did].[Value],
                        [R] = ROW_NUMBER() OVER (PARTITION BY [did].[DeviceSessionId] ORDER BY [did].[TimestampUTC] DESC)
                     FROM
                        [dbo].[DeviceInfoData] AS [did]
                     WHERE
                        [did].[DeviceSessionId] = [DeviceSessions].[Id]
                        AND [did].[Name] = N'Unit'
                    ) AS [LatestDeviceInfo]
                 WHERE
                    [LatestDeviceInfo].[R] = 1
                ) AS [InfoUnit]
    OUTER APPLY (SELECT
                    [LatestDeviceInfo].[Value]
                 FROM
                    (SELECT
                        [did].[Value],
                        [R] = ROW_NUMBER() OVER (PARTITION BY [did].[DeviceSessionId] ORDER BY [did].[TimestampUTC] DESC)
                     FROM
                        [dbo].[DeviceInfoData] AS [did]
                     WHERE
                        [did].[DeviceSessionId] = [DeviceSessions].[Id]
                        AND [did].[Name] = N'Transmitter'
                    ) AS [LatestDeviceInfo]
                 WHERE
                    [LatestDeviceInfo].[R] = 1
                ) AS [InfoTransmitter];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_DeviceSessionAssignment';

