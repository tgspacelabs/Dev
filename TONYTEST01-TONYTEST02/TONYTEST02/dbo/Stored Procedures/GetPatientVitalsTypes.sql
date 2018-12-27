
CREATE PROCEDURE [dbo].[GetPatientVitalsTypes] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN
	SELECT 
		Code.code_id AS [TYPE],
		Code.code AS CODE,
		Code.int_keystone_cd AS UNITS
	  FROM 
	  int_misc_code Code
	  INNER JOIN 
	  (
		  select distinct test_cid 
		  from int_result  where patient_id = @patient_id
	  ) result_cid
	  on result_cid.test_cid = Code.code_id
    
 UNION ALL

SELECT 
		GdsCodeMap.CodeId AS [TYPE],
		GdsCodeMap.GdsCode AS CODE,
		GdsCodeMap.Units AS UNITS
		FROM GdsCodeMap 
		INNER JOIN 
		(	select distinct [VitalsData].[Name], [VitalsData].[FeedTypeId] 
			from VitalsData
			INNER JOIN TopicSessions on TopicSessions.Id = VitalsData.TopicSessionId
			INNER JOIN [dbo].[PatientSessionsMap] on PatientSessionsMap.PatientSessionId = TopicSessions.PatientSessionId
			where PatientId=@patient_id
		) VitalTypes on GdsCodeMap.FeedTypeId = [VitalTypes].[FeedTypeId] AND GdsCodeMap.[Name] = [VitalTypes].[Name]

END

