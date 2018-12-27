

CREATE PROCEDURE [dbo].[GetPatientVitalsTimeHistory]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql VARCHAR(MAX) = '
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
';

    SET @sql = REPLACE(@sql, '@patient_id', QUOTENAME(@patient_id, ''''));

    SET @sql = @sql + ' order by result_ft asc';

    EXEC (@sql);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsTimeHistory';

