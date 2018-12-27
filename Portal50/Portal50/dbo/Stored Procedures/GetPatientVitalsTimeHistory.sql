
CREATE PROCEDURE [dbo].[GetPatientVitalsTimeHistory] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN  

declare @newPatient UNIQUEIDENTIFIER=(select top 1 PatientId from [dbo].[PatientSessionsMap] where PatientId=@patient_id)

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

if(@newPatient is not null) -- explicit sorting is only necessary ET data is present, as UVSL data is already sorted in the index.
set @sql = @sql + ' order by result_ft asc'

exec (@sql)
END
