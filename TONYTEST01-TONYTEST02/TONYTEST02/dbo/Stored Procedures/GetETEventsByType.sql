
CREATE PROCEDURE [dbo].[GetETEventsByType]
  (
  @patient_id	UNIQUEIDENTIFIER,
  @Category	INT,
  @Type         INT,
  @StartTime	BIGINT,
  @EndTime	BIGINT
  )
AS
BEGIN
SELECT distinct ev.Id AS ID
      ,[CategoryValue] AS CATEGORY_VALUE
      ,[Type] AS TYPE
      ,[Subtype] AS SUBTYPE
      ,[Value1] AS VALUE1
      ,[Value2] AS VALUE2
      ,[status] AS STATUS_VALUE
      ,[valid_leads] AS LEADS
	  ,dbo.fnDateTimeToFileTime([TimeStampUTC]) AS FT_TIME
      ,pts.PatientId AS PATIENT_ID
   FROM [EventsData] ev inner join TopicSessions on TopicSessions.Id = ev.TopicSessionId
   inner join v_PatientTopicSessions pts on TopicSessions.Id = pts.TopicSessionId
   where pts.PatientId = @patient_id and CategoryValue = @Category and Type = @Type
   and ( dbo.fnDateTimeToFileTime([TimeStampUTC]) >= @StartTime ) AND ( dbo.fnDateTimeToFileTime([TimeStampUTC]) <= @EndTime )
   order by FT_TIME
END


