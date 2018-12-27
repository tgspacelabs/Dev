
CREATE PROCEDURE [dbo].[GetETTechAlarms]
  (
  @PatientID UNIQUEIDENTIFIER,
  @StartTime  BIGINT,
  @EndTime	  BIGINT
  )
AS
BEGIN

	declare @l_PatientID UNIQUEIDENTIFIER = @PatientID
	declare @l_StartTime  BIGINT = @StartTime 
	declare @l_EndTime	  BIGINT=@EndTime

	declare @end_dt datetime = dbo.fnFileTimeToDateTime(@l_EndTime)
	declare @start_dt datetime=dbo.fnFileTimeToDateTime(@l_StartTime)

	SELECT 
		[IDEnumValue] AS [ALARM_TYPE]
	   ,dbo.fnDateTimeToFileTime([StartDateTime]) AS FT_START
	   ,dbo.fnDateTimeToFileTime([EndDateTime]) AS FT_END
	FROM
				(SELECT	ROW_NUMBER() OVER (PARTITION BY AlarmId ORDER BY AcquiredDateTimeUtc DESC) AS rowNumber, 
						StartDateTime, 
						EndDateTime,
						IDEnumValue,
						TopicSessionId
				FROM [dbo].[GeneralAlarmsData]
				where
					TopicSessionId IN (select TopicSessionId from v_PatientTopicSessions where PatientId = @l_PatientID)
					AND IDEnumValue in (105, 102, 204) -- 105 is signal loss, 102 is interference, 204 is ElectrodeOff_LL
					AND (
						EndDateTime >= @start_dt  and  EndDateTime <= @end_dt 
						OR StartDateTime >= @start_dt and StartDateTime <= @end_dt
					)

				) EndAlarmPackets
				WHERE rowNumber = 1 
	order by [IDEnumValue],[StartDateTime]
END


