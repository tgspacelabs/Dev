CREATE PROCEDURE [dbo].[GetPatientVitalsTimeHistory] (@patient_id UNIQUEIDENTIFIER) 
AS
BEGIN  
DECLARE @sql VARCHAR(MAX) = '
SELECT distinct
		result_ft,
		result_dt
	FROM
		dbo.int_result
	WHERE
		patient_id = @patient_id
		
UNION ALL

	SELECT dbo.fnDateTimeToFileTime(TimestampUTC) as result_ft, dbo.fnUtcDateTimeToLocalTime(TimestampUTC) as result_dt from [dbo].[VitalsData]
	inner join dbo.TopicSessions on VitalsData.TopicSessionId = TopicSessions.Id
	WHERE TopicSessions.PatientSessionId IN
	(
		SELECT PatientSessionId
		FROM dbo.PatientSessionsMap
		INNER JOIN
		(
		SELECT MAX(Sequence) AS MaxSeq
			FROM dbo.PatientSessionsMap
			GROUP BY PatientSessionId
		) AS PatientSessionMaxSeq
			ON Sequence = PatientSessionMaxSeq.MaxSeq
		WHERE PatientId = @patient_id
	)
'

SET @sql = REPLACE(@sql, '@patient_id', QUOTENAME(@patient_id, ''''))

SET @sql = @sql + ' ORDER BY result_ft asc'

EXEC (@sql)
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the patients'' vitals time history.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsTimeHistory';

