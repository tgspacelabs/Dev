


/* NEW STORED PROCEDURES FOR ET DATA */


CREATE PROCEDURE [dbo].[GetETBeatTimeLog]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
BEGIN
DECLARE @l_patientId UNIQUEIDENTIFIER= @patient_id
SELECT 
      [Type] AS TYPE
      ,[Subtype] AS SUBTYPE
      ,[Value1] AS VALUE1
      ,[Value2] AS VALUE2
      ,[status] AS STATUS_VALUE
      ,[valid_leads] AS LEADS
      ,dbo.fnDateTimeToFileTime([EventsData].[TimeStampUTC]) AS FT_TIME
      ,@patient_id AS PATIENT_ID
   FROM [EventsData] 
    INNER JOIN v_PatientTopicSessions on v_PatientTopicSessions.TopicSessionId = EventsData.TopicSessionId
   where v_PatientTopicSessions.PatientId=@l_patientId
   and CategoryValue = 0
   ORDER BY FT_TIME

END

