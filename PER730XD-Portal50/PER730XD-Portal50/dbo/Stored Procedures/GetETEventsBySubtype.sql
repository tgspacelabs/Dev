
CREATE PROCEDURE [dbo].[GetETEventsBySubtype]
  (
  @patient_id    UNIQUEIDENTIFIER,
  @Subtype    INT,
  @StartTime    BIGINT,
  @EndTime    BIGINT
  )
AS
BEGIN

DECLARE  @l_StartTime    BIGINT=@StartTime
DECLARE  @l_EndTime        BIGINT=@EndTime

DECLARE  @l_StartTime_dt    DATETIME = dbo.fnFileTimeToDateTime(@l_StartTime);
DECLARE  @l_EndTime_dt        DATETIME = dbo.fnFileTimeToDateTime(@l_EndTime);


select 
    ISNULL(EndOrUpdateEventsData.Value1, StartValue1) as VALUE1 -- return the most recent available value  
    ,ISNULL(EndOrUpdateEventsData.Value2, StartValue2) as VALUE2 -- return the most recent available value  
    ,ISNULL(EndOrUpdateEventsData.[status], StartStatus) as STATUS_VALUE -- return the most recent available value  
    ,ISNULL(EndOrUpdateEventsData.valid_leads, StartValidLeads) as LEADS -- return the most recent available value  
      ,dbo.fnDateTimeToFileTime(StartTime) as FT_TIME_START -- ALWAYS RETURN THE START TIME OF THE EVENT EVEN IF IT'S OUT OF THE REQUESTED RANGE
      ,dbo.fnDateTimeToFileTime(EndOrUpdateTime) AS FT_TIME_END
      ,StartTime
      ,EndOrUpdateTime
from
(select 
    EventsDataStart.Value1 as StartValue1,
    EventsDataStart.Value2 as StartValue2,
    EventsDataStart.[status] as StartStatus,
    EventsDataStart.valid_leads as StartValidLeads,
    EventsDataStart.TopicSessionId,
    EventsDataStart.CategoryValue,
    EventsDataStart.Subtype,
    TimeStampUTC as StartTime,
(select 
    ISNULL(
            (select top 1 EventsDataEnd.TimeStampUTC from EventsData EventsDataEnd where [Type] = 4 and CategoryValue = 2 and SubType= @Subtype and EventsDataEnd.TopicSessionId = EventsDataStart.TopicSessionId and EventsDataEnd.TimeStampUTC > EventsDataStart.TimeStampUTC  and EventsDataEnd.TimeStampUTC <= @l_EndTime_dt ORDER BY TimeStampUTC ASC),
            (select top 1 EventsDataUpdate.TimeStampUTC from EventsData EventsDataUpdate where [Type] = 12 and CategoryValue = 2 and SubType= @Subtype and EventsDataUpdate.TopicSessionId = EventsDataStart.TopicSessionId and TimeStampUTC > EventsDataStart.TimeStampUTC and EventsDataUpdate.TimeStampUTC <= @l_EndTime_dt ORDER BY TimeStampUTC DESC) 
        )
) as EndOrUpdateTime
 from EventsData EventsDataStart
 INNER JOIN v_PatientTopicSessions on v_PatientTopicSessions.TopicSessionId = EventsDataStart.TopicSessionId
  where PatientId = @patient_id
          and [Type] = 3
          and CategoryValue = 2
          and Subtype = @Subtype
          and TimeStampUTC < @l_EndTime_dt)
  AllRhythmEvents
    LEFT JOIN EventsData EndOrUpdateEventsData on EndOrUpdateEventsData.CategoryValue = AllRhythmEvents.CategoryValue and EndOrUpdateEventsData.Subtype = AllRhythmEvents.Subtype and EndOrUpdateEventsData.TopicSessionId = AllRhythmEvents.TopicSessionId and EndOrUpdateEventsData.TimeStampUTC = AllRhythmEvents.EndOrUpdateTime
  where 
  (EndOrUpdateTime IS NULL OR EndOrUpdateTime > @l_StartTime_dt) -- do not filter out the start time of the event as we need to collect something when the request time range is between an event start and end times, and we still need that active event to be returned
  
END

