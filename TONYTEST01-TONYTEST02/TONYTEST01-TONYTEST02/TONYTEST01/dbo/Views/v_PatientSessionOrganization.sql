
CREATE VIEW [dbo].[v_PatientSessionOrganization]
AS
SELECT DISTINCT [PatientData].[PatientSessionId],
				[OrganizationId] AS [UnitId]
	FROM [dbo].[PatientData]
	INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[PatientSessionId]=[PatientData].[PatientSessionId]
	INNER JOIN [dbo].[DeviceSessions] ON [DeviceSessions].[Id]=[TopicSessions].[DeviceSessionId]
	INNER JOIN [dbo].[v_DeviceSessionOrganization] ON [v_DeviceSessionOrganization].[DeviceSessionId]=[DeviceSessions].[Id]
