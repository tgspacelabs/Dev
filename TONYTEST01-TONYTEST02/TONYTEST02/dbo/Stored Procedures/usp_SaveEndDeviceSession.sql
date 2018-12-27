﻿
CREATE PROCEDURE [dbo].[usp_SaveEndDeviceSession]
	(@endDeviceSessionData dbo.DeviceSessionDataType READONLY)
AS
BEGIN
	
	SET NOCOUNT ON

	/* We close all open topics still open on the device sessions that we are closing */
	DECLARE @closedDeviceSessions
	AS TABLE
	(
		DeviceSessionId UNIQUEIDENTIFIER NOT NULL,
		EndTimeUTC datetime NOT NULL
	)

	INSERT INTO @closedDeviceSessions
	SELECT ss.Id, dd.EndTimeUTC
	FROM dbo.DeviceSessions AS ss
		INNER JOIN @endDeviceSessionData AS dd
		ON ss.Id = dd.Id
		AND ss.EndTimeUTC IS NULL

	UPDATE dbo.TopicSessions
	SET TopicSessions.EndTimeUTC = x.EndTimeUTC
	FROM @closedDeviceSessions AS x
	WHERE TopicSessions.DeviceSessionId = x.DeviceSessionID	AND TopicSessions.EndTimeUTC IS NULL

	MERGE INTO [dbo].[DeviceSessions] AS [Target]
		USING @endDeviceSessionData AS [Source]
		ON [Source].[Id] = [Target].[Id]
		WHEN NOT MATCHED BY TARGET
			THEN INSERT ([Id], [DeviceId], [EndTimeUTC])
				VALUES
				(
					[Source].[Id],
					[Source].[DeviceId],
					[Source].[EndTimeUTC]
				)
			WHEN MATCHED
				THEN UPDATE SET [Target].[EndTimeUTC] = [Source].[EndTimeUTC]
	;

END

