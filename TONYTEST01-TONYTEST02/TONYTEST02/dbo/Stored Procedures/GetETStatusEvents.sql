
CREATE PROCEDURE [dbo].[GetETStatusEvents]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
BEGIN
declare @l_patientId UNIQUEIDENTIFIER= @patient_id
SELECT
      [Subtype] AS SUBTYPE
      ,[Value1] AS VALUE1
      ,[status] AS STATUS_VALUE
      ,[valid_leads] AS LEADS
	  ,dbo.fnDateTimeToFileTime(ev.[TimeStampUTC]) AS FT_TIME
      ,@patient_id AS PATIENT_ID
	  ,ISNULL(dbo.fnDateTimeToFileTime([TopicSessions].[EndTimeUTC]), -1) AS MAX_FT_TIME
   FROM [EventsData] ev 
	INNER JOIN v_PatientTopicSessions on v_PatientTopicSessions.TopicSessionId = ev.TopicSessionId
	INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id]=ev.TopicSessionId
   where v_PatientTopicSessions.PatientId=@l_patientId
	and CategoryValue = 2 and Type = 1
   order by FT_TIME
END


