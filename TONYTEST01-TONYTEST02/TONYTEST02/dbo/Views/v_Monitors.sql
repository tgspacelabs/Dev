
CREATE VIEW [dbo].[v_Monitors]
AS
	SELECT [monitor_id],
		   [unit_org_id],
		   [network_id],
		   [node_id],
		   [bed_id],
		   [channel] = NULL,
		   [bed_cd],
		   [room],
		   [monitor_dsc],
		   [monitor_name],
		   [monitor_type_cd],
		   [subnet],
		   [assignment_cd] = 'ICS'
		FROM [dbo].[int_monitor]

UNION

	SELECT [monitor_id] = [Devices].[Id],
		   [unit_org_id] = [OrganizationId],
		   [network_id] = [DeviceInfoFarm].[Value],
		   [node_id] = NULL,
		   [bed_id] = NULL,
		   [channel] = [DeviceInfoTransmitter].[Value],
		   [bed_cd] = [DeviceInfoBed].[Value],
		   [room] = [Devices].[Room],
		   [monitor_dsc] = [Devices].[Description],
		   [monitor_name] = [DeviceInfoDeviceName].[Value],
		   [monitor_type_cd] = NULL,
		   [subnet] = NULL,
		   [assignment_cd] =
		   CASE
				WHEN [DeviceInfoDeviceType].[Value] = 'ETtransmitter' THEN 'DEVICE'
				ELSE 'ICS'
		   END

		FROM [dbo].[Devices]
		INNER JOIN
		(
			SELECT [Id] AS [DeviceSessionId], [DeviceId],
				   [R] = ROW_NUMBER() OVER
				   (
					 PARTITION BY [DeviceId]
					 ORDER BY [BeginTimeUTC] DESC
				   )
				FROM [dbo].[DeviceSessions]
		) 
		AS [LatestSession] 
		ON [LatestSession].[R] = 1 AND [LatestSession].[DeviceId] = [Devices].[Id]
		LEFT OUTER JOIN [dbo].[v_DeviceSessionOrganization] ON [v_DeviceSessionOrganization].[DeviceSessionId] = [LatestSession].[DeviceSessionId]
		LEFT OUTER JOIN [dbo].[v_DeviceSessionInfo] AS [DeviceInfoDeviceType] ON [DeviceInfoDeviceType].[Name] = 'DeviceType' AND [DeviceInfoDeviceType].[DeviceSessionId]=[LatestSession].[DeviceSessionId]
		LEFT OUTER JOIN [dbo].[v_DeviceSessionInfo] AS [DeviceInfoFarm] ON [DeviceInfoFarm].[Name] = 'Farm' AND [DeviceInfoFarm].[DeviceSessionId]=[LatestSession].[DeviceSessionId]
		LEFT OUTER JOIN [dbo].[v_DeviceSessionInfo] AS [DeviceInfoTransmitter] ON [DeviceInfoTransmitter].[Name] = 'Transmitter' AND [DeviceInfoTransmitter].[DeviceSessionId]=[LatestSession].[DeviceSessionId]
		LEFT OUTER JOIN [dbo].[v_DeviceSessionInfo] AS [DeviceInfoDeviceName] ON [DeviceInfoDeviceName].[Name] = 'DeviceName' AND [DeviceInfoDeviceName].[DeviceSessionId]=[LatestSession].[DeviceSessionId]
		LEFT OUTER JOIN [dbo].[v_DeviceSessionInfo] AS [DeviceInfoBed] ON [DeviceInfoBed].[Name] = 'Bed' AND [DeviceInfoBed].[DeviceSessionId]=[LatestSession].[DeviceSessionId]
		
