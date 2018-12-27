
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

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_DeviceSessionInfo';

