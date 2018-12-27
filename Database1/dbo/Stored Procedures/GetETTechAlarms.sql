

CREATE PROCEDURE [dbo].[GetETTechAlarms]
    (
     @PatientID UNIQUEIDENTIFIER,
     @StartTime BIGINT,
     @EndTime BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @l_PatientID UNIQUEIDENTIFIER = @PatientID;
    DECLARE @l_StartTime BIGINT = @StartTime; 
    DECLARE @l_EndTime BIGINT= @EndTime;

    DECLARE @end_dt DATETIME = [dbo].[fnFileTimeToDateTime](@l_EndTime);
    DECLARE @start_dt DATETIME= [dbo].[fnFileTimeToDateTime](@l_StartTime);

    SELECT
        [EndAlarmPackets].[IDEnumValue] AS [ALARM_TYPE],
        [dbo].[fnDateTimeToFileTime]([EndAlarmPackets].[StartDateTime]) AS [FT_START],
        [dbo].[fnDateTimeToFileTime]([EndAlarmPackets].[EndDateTime]) AS [FT_END]
    FROM
        (SELECT
            ROW_NUMBER() OVER (PARTITION BY [AlarmId] ORDER BY [AcquiredDateTimeUTC] DESC) AS [rowNumber],
            [StartDateTime],
            [EndDateTime],
            [IDEnumValue],
            [TopicSessionId]
         FROM
            [dbo].[GeneralAlarmsData]
         WHERE
            [TopicSessionId] IN (SELECT
                                    [TopicSessionId]
                                 FROM
                                    [dbo].[v_PatientTopicSessions]
                                 WHERE
                                    [PatientId] = @l_PatientID)
            AND [IDEnumValue] IN (105, 102, 204) -- 105 is signal loss, 102 is interference, 204 is ElectrodeOff_LL
            AND ([EndDateTime] >= @start_dt
            AND [EndDateTime] <= @end_dt
            OR [StartDateTime] >= @start_dt
            AND [StartDateTime] <= @end_dt
            )
        ) [EndAlarmPackets]
    WHERE
        [EndAlarmPackets].[rowNumber] = 1
    ORDER BY
        [EndAlarmPackets].[IDEnumValue],
        [EndAlarmPackets].[StartDateTime];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETTechAlarms';

