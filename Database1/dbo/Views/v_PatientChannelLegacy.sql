CREATE VIEW [dbo].[v_PatientChannelLegacy]
WITH
     SCHEMABINDING
AS
SELECT
    [vadt].[DeviceSessionId],
    [vadt].[PatientId],
    [ds].[DeviceId],
    [vadt].[TypeId],
    [vadt].[TopicTypeId],
    ISNULL([vadt].[TypeId], [vadt].[TopicTypeId]) AS [ChannelTypeId],
    [vadt].[Active]
FROM
    [dbo].[v_AvailableDataTypes] AS [vadt]
    INNER JOIN [dbo].[DeviceSessions] AS [ds] ON [ds].[Id] = [vadt].[DeviceSessionId];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_PatientChannelLegacy';

