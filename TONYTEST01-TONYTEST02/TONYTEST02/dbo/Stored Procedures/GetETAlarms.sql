
CREATE PROCEDURE [dbo].[GetETAlarms]
  (
  @PatientID UNIQUEIDENTIFIER,
  @AlarmType BIGINT,
  @StartTime  BIGINT,
  @EndTime	  BIGINT
  )
AS
BEGIN

	declare @l_PatientID UNIQUEIDENTIFIER = @PatientID
	declare @l_AlarmType  BIGINT = @AlarmType
	declare @l_StartTime  BIGINT = @StartTime 
	declare @l_EndTime	  BIGINT=@EndTime

	declare @end_dt datetime = dbo.fnFileTimeToDateTime(@l_EndTime)
	declare @start_dt datetime=dbo.fnFileTimeToDateTime(@l_StartTime)

	SELECT 
	[IDEnumValue] AS [TYPE]
    ,dbo.fnDateTimeToFileTime([StartDateTime]) AS FT_START
    ,dbo.fnDateTimeToFileTime([EndDateTime]) AS FT_END
	FROM
	[dbo].[GeneralAlarmsData]
	inner join v_PatientTopicSessions on v_PatientTopicSessions.TopicSessionId = [GeneralAlarmsData].TopicSessionId
	where
		PatientId = @l_PatientID
		AND IDEnumValue = @l_AlarmType
		AND (
			EndDateTime >= @start_dt  and  EndDateTime <= @end_dt 
			OR StartDateTime >= @start_dt and StartDateTime <= @end_dt
		)
		AND EnumGroupId = 'F6DE38B7-B737-AE89-7486-CF67C64ECF3F'
	order by [StartDateTime]
END


