
CREATE PROCEDURE [dbo].[GetPatientVitalsByGDSCodes]
    (
     @gds_codes [dbo].[GdsCodes] READONLY,
     @patient_id UNIQUEIDENTIFIER,
     @start_dt_utc DATETIME, --UTC
     @end_dt_utc DATETIME --UTC
    )
AS
DECLARE @l_start_ft BIGINT = [dbo].[fnDateTimeToFileTime](@start_dt_utc);
DECLARE @l_end_ft BIGINT = [dbo].[fnDateTimeToFileTime](@end_dt_utc);

BEGIN
    SET NOCOUNT ON;

    SELECT
        [ALLVITAS].[ROW_NUMBER],
        [ALLVITAS].[GDS_CODE],
        [ALLVITAS].[VALUE],
        [ALLVITAS].[RESULT_TIME],
        [ALLVITAS].[RESULT_FILE_TIME]
    FROM
        (SELECT
            ROW_NUMBER() OVER (PARTITION BY [MISC].[code] ORDER BY [RESULT].[result_ft] DESC) AS "ROW_NUMBER",
            [MISC].[code] AS [GDS_CODE],
            [RESULT].[result_value] AS [VALUE],
            CAST(NULL AS DATETIME) AS [RESULT_TIME],
            [RESULT].[result_ft] AS [RESULT_FILE_TIME]
         FROM
            [dbo].[int_result] AS [RESULT]
            INNER JOIN [dbo].[int_misc_code] AS [MISC] ON [MISC].[code_id] = [RESULT].[test_cid]
            INNER JOIN @gds_codes [GDSCODES] ON [MISC].[code] = [GDSCODES].[GdsCode]
         WHERE
            [RESULT].[patient_id] = @patient_id
            AND [RESULT].[result_ft] >= @l_start_ft
            AND [RESULT].[result_ft] <= @l_end_ft
            AND [RESULT].[result_value] IS NOT NULL
         UNION ALL
         SELECT
            ROW_NUMBER() OVER (PARTITION BY [VitalsData].[FeedTypeId], [VitalsData].[TopicSessionId] ORDER BY [TimestampUTC] DESC) AS 'ROW_NUMBER',
            [GdsCodeMap].[GdsCode] AS [GDS_CODE],
            [Value] AS [VALUE],
            CAST(NULL AS DATETIME) AS [RESULT_TIME],
            [dbo].[fnDateTimeToFileTime]([TimestampUTC]) AS [RESULT_FILE_TIME]
         FROM
            [dbo].[VitalsData]
            INNER JOIN [dbo].[GdsCodeMap] ON [GdsCodeMap].[FeedTypeId] = [VitalsData].[FeedTypeId]
                                             AND [GdsCodeMap].[Name] = [VitalsData].[Name]
            INNER JOIN @gds_codes [GDSCODES] ON [GDSCODES].[GdsCode] = [GdsCodeMap].[GdsCode]
            INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId] = [VitalsData].[TopicSessionId]
         WHERE
            [PatientId] = @patient_id
            AND [TimestampUTC] >= @start_dt_utc
            AND [TimestampUTC] <= @end_dt_utc
        ) [ALLVITAS]
    WHERE
        [ALLVITAS].[ROW_NUMBER] = 1;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsByGDSCodes';

