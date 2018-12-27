
CREATE PROCEDURE [dbo].[GetETStatusEvents]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
BEGIN
DECLARE @l_patientId UNIQUEIDENTIFIER= @patient_id
SELECT
      [Subtype] AS SUBTYPE
      ,[Value1] AS VALUE1
      ,[status] AS STATUS_VALUE
      ,[valid_leads] AS LEADS
      ,dbo.fnDateTimeToFileTime(ev.[TimeStampUTC]) AS FT_TIME
      ,@patient_id AS PATIENT_ID
   FROM [EventsData] ev 
    INNER JOIN v_PatientTopicSessions on v_PatientTopicSessions.TopicSessionId = ev.TopicSessionId
   where v_PatientTopicSessions.PatientId=@l_patientId
    and CategoryValue = 2 and Type = 1
   ORDER BY FT_TIME
END

