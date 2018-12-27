

CREATE PROCEDURE [dbo].[GetPatientVitalsByType]
    (
     @patient_id UNIQUEIDENTIFIER,
     @type INT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Result].[result_value] AS [VALUE],
        CAST(NULL AS DATETIME) AS [RESULT_TIME],
        [Result].[Sequence] AS [SEQ_NUM],
        [Result].[result_ft] AS [RESULT_FILE_TIME]
    FROM
        [dbo].[int_result] AS [Result]
        INNER JOIN [dbo].[int_misc_code] AS [Code] ON [Result].[test_cid] = [Code].[code_id]
    WHERE
        ([Result].[patient_id] = @patient_id)
        AND ([Code].[code_id] = @type)
    UNION ALL
    SELECT
        [Value] AS [VALUE],
        CAST(NULL AS DATETIME) AS [RESULT_TIME],
        0 AS [SEQ_NUM],
        [dbo].[fnDateTimeToFileTime]([TimestampUTC]) AS [RESULT_FILE_TIME]
    FROM
        [dbo].[VitalsData]
        INNER JOIN [dbo].[GdsCodeMap] ON [CodeId] = @type
                                         AND [GdsCodeMap].[FeedTypeId] = [VitalsData].[FeedTypeId]
                                         AND [GdsCodeMap].[Name] = [VitalsData].[Name]
    WHERE
        [TopicSessionId] IN (SELECT DISTINCT
                                [Id]
                             FROM
                                [dbo].[TopicSessions]
                             WHERE
                                [PatientSessionId] IN (SELECT DISTINCT
                                                        [PatientSessionId]
                                                       FROM
                                                        [dbo].[PatientSessionsMap]
                                                       WHERE
                                                        [PatientId] = @patient_id))
    ORDER BY
        [RESULT_FILE_TIME] ASC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsByType';

