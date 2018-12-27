

CREATE PROCEDURE [dbo].[GetPatientVitalsByGDSCodes]
  (
  @gds_codes [dbo].[GdsCodes] READONLY, 
  @patient_id UNIQUEIDENTIFIER,
  @start_dt_utc   DATETIME, --UTC
  @end_dt_utc     DATETIME --UTC
  )
AS

  declare @l_start_ft   BIGINT = dbo.fnDateTimeToFileTime(@start_dt_utc)
  declare @l_end_ft     BIGINT = dbo.fnDateTimeToFileTime(@end_dt_utc);

  BEGIN
  
    
    
SELECT * from (SELECT ROW_NUMBER() over(PARTITION BY MISC.code ORDER BY RESULT.[result_ft] DESC) AS "ROW_NUMBER",
MISC.code as GDS_CODE,
			RESULT.result_value AS VALUE,
			CAST(NULL AS DATETIME) AS RESULT_TIME,
			RESULT.result_ft AS RESULT_FILE_TIME
   FROM int_result AS RESULT
	INNER JOIN int_misc_code AS MISC on MISC.code_id = RESULT.test_cid 
	INNER JOIN @gds_codes GDSCODES on MISC.code = GDSCODES.GdsCode
	WHERE
    RESULT.patient_id = @patient_id
    AND RESULT.result_ft >= @l_start_ft 
    AND RESULT.result_ft <= @l_end_ft
    AND RESULT.result_value IS NOT NULL

   UNION ALL
  

SELECT ROW_NUMBER() OVER (PARTITION BY VitalsData.FeedTypeId, VitalsData.TopicSessionId ORDER BY TimestampUTC DESC) AS 'ROW_NUMBER',
	GdsCodeMap.GdsCode AS GDS_CODE,
	VitalsData.Value as VALUE,
	CAST(NULL AS DATETIME) as RESULT_TIME,
	dbo.fnDateTimeToFileTime(TimestampUTC) AS RESULT_FILE_TIME
FROM VitalsData
	INNER JOIN GdsCodeMap ON GdsCodeMap.FeedTypeId = [VitalsData].[FeedTypeId] AND GdsCodeMap.[Name] = [VitalsData].[Name]
	INNER JOIN @gds_codes GDSCODES on GDSCODES.GdsCode = GdsCodeMap.GdsCode
	INNER JOIN v_PatientTopicSessions on v_PatientTopicSessions.TopicSessionId = VitalsData.TopicSessionId
		WHERE PatientId=@patient_id
			AND TimeStampUtc >= @start_dt_utc
			AND TimeStampUtc <= @end_dt_utc
) ALLVITAS where ROW_NUMBER = 1;

END


