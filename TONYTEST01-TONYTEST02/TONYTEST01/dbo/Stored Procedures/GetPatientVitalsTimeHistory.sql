
CREATE PROCEDURE [dbo].[GetPatientVitalsTimeHistory] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN  



declare @sql varchar(max) = '
SELECT distinct
		result_ft,
		result_dt
	FROM
		dbo.int_result
	WHERE
		patient_id = @patient_id
		
UNION ALL
	SELECT dbo.fnDateTimeToFileTime(TimestampUTC) as result_ft, dbo.fnUtcDateTimeToLocalTime(TimestampUTC) as result_dt from VitalsData	
	WHERE [VitalsData].TopicSessionId IN (SELECT Id FROM TopicSessions WHERE PatientSessionId IN ( SELECT  DISTINCT PatientSessionId FROM PatientSessionsMap WHERE PatientId = @patient_id))
'

set @sql = REPLACE(@sql, '@patient_id', QUOTENAME(@patient_id, ''''))

set @sql = @sql + ' order by result_ft asc'

exec (@sql)
END
