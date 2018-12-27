

CREATE PROCEDURE [dbo].[GetETAlarms]
    (
     @PatientID UNIQUEIDENTIFIER,
     @AlarmType BIGINT,
     @StartTime BIGINT,
     @EndTime BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @l_PatientID UNIQUEIDENTIFIER = @PatientID;
    DECLARE @l_AlarmType BIGINT = @AlarmType;
    DECLARE @l_StartTime BIGINT = @StartTime; 
    DECLARE @l_EndTime BIGINT= @EndTime;

    DECLARE @end_dt DATETIME = [dbo].[fnFileTimeToDateTime](@l_EndTime);
    DECLARE @start_dt DATETIME= [dbo].[fnFileTimeToDateTime](@l_StartTime);

    SELECT
        [IDEnumValue] AS [TYPE],
        [dbo].[fnDateTimeToFileTime]([StartDateTime]) AS [FT_START],
        [dbo].[fnDateTimeToFileTime]([EndDateTime]) AS [FT_END]
    FROM
        [dbo].[GeneralAlarmsData]
        INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId] = [GeneralAlarmsData].[TopicSessionId]
    WHERE
        [PatientId] = @l_PatientID
        AND [IDEnumValue] = @l_AlarmType
        AND ([EndDateTime] >= @start_dt
        AND [EndDateTime] <= @end_dt
        OR [StartDateTime] >= @start_dt
        AND [StartDateTime] <= @end_dt
        )
        AND [EnumGroupId] = 'F6DE38B7-B737-AE89-7486-CF67C64ECF3F'
    ORDER BY
        [StartDateTime];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETAlarms';

