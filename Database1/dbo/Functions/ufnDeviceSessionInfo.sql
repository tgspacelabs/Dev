
CREATE FUNCTION [dbo].[ufnDeviceSessionInfo]
    (
     @DeviceSessionId UNIQUEIDENTIFIER,
     @Name NVARCHAR(25)
    )
RETURNS TABLE
    WITH SCHEMABINDING
    AS
RETURN
    (SELECT
        [LatestDeviceInfo].[Value]
     FROM
        (SELECT
            [did].[Value],
            [R] = ROW_NUMBER() OVER (PARTITION BY @DeviceSessionId ORDER BY [did].[TimestampUTC] DESC)
         FROM
            [dbo].[DeviceInfoData] AS [did]
         WHERE
            [did].[DeviceSessionId] = @DeviceSessionId
            AND [did].[Name] = @Name
        ) AS [LatestDeviceInfo]
     WHERE
        [LatestDeviceInfo].[R] = 1
    );
