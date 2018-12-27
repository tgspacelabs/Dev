
CREATE VIEW [dbo].[v_PatientChannelLegacy]
AS
SELECT     
	[DeviceSessionId] AS DeviceSessionId,
	[PatientId],
	[DeviceId],
	[v_AvailableDataTypes].[TypeId],
	[v_AvailableDataTypes].TopicTypeId,
	ISNULL([v_AvailableDataTypes].[TypeId],[v_AvailableDataTypes].[TopicTypeId]) as ChannelTypeId,
	Active
FROM        
	[v_AvailableDataTypes]
	inner join DeviceSessions on DeviceSessions.Id = v_AvailableDataTypes.DeviceSessionId
