
CREATE VIEW [dbo].[v_DeviceSessionInfo]
AS
SELECT [DeviceSessionId],
       [Name],
       [Value],
       [TimestampUTC]
    FROM 
    (
        SELECT [DeviceSessionId],
               [TimestampUTC],
               [Name],
               [Value],
               [R] = ROW_NUMBER() OVER
               (
                    PARTITION BY [DeviceSessionId], [Name]
                    ORDER BY [TimestampUTC] DESC
               )
        FROM [dbo].[DeviceInfoData]
    )
    AS [LatestDeviceInfo]
    WHERE [LatestDeviceInfo].[R] = 1
