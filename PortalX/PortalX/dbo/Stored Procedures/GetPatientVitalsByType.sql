CREATE PROCEDURE [dbo].[GetPatientVitalsByType]
    (
    @patient_id UNIQUEIDENTIFIER,
    @type INT)
AS
BEGIN
    SELECT
        [Result].[result_value] AS [VALUE],
        CAST(NULL AS DATETIME) AS [RESULT_TIME],
        [Result].[Sequence] AS [SEQ_NUM],
        [Result].[result_ft] AS [RESULT_FILE_TIME],
        CAST(1 AS BIT) AS [IS_RESULT_LOCALIZED]
    FROM [dbo].[int_result] AS [Result]
        INNER JOIN [dbo].[int_misc_code] AS [Code]
            ON [Result].[test_cid] = [Code].[code_id]
    WHERE [Result].[patient_id] = @patient_id
          AND [Code].[code_id] = @type

    UNION ALL

    SELECT
        [vd].[Value] AS [VALUE],
        CAST(NULL AS DATETIME) AS [RESULT_TIME],
        0 AS [SEQ_NUM],
        [TimestampUTCFileTime].[FileTime] AS [RESULT_FILE_TIME], -- Use the Table Value Function column to improve performance
        CAST(0 AS BIT) AS [IS_RESULT_LOCALIZED]
    FROM [dbo].[VitalsData] AS [vd]
        INNER JOIN [dbo].[GdsCodeMap] AS [gcm]
            ON [gcm].[CodeId] = @type
               AND [gcm].[FeedTypeId] = [vd].[FeedTypeId]
               AND [gcm].[Name] = [vd].[Name]
        INNER JOIN [dbo].[TopicSessions] AS [ts]
            ON [ts].[Id] = [vd].[TopicSessionId]
        CROSS APPLY [dbo].[fntDateTimeToFileTime]([vd].[TimestampUTC]) AS [TimestampUTCFileTime] -- Use the Table Value Function instead to improve performance
        INNER JOIN [dbo].[PatientSessionsMap] AS [psm]
            INNER JOIN (SELECT MAX([psm2].[Sequence]) AS [MaxSeq]
                        FROM [dbo].[PatientSessionsMap] AS [psm2]
                        WHERE [psm2].[PatientId] = @patient_id -- Include @patient_id within the inner query to get only the patient session we requested instead of all patient sessions
                        GROUP BY [psm2].[PatientSessionId]) AS [PatientSessionMaxSeq]
                ON [psm].[Sequence] = [PatientSessionMaxSeq].[MaxSeq]
            ON [ts].[PatientSessionId] = [psm].[PatientSessionId]
    ORDER BY [RESULT_FILE_TIME] ASC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Return the patients'' vitals by type.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsByType';

