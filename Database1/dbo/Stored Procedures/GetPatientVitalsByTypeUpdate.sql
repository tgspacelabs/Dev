

CREATE PROCEDURE [dbo].[GetPatientVitalsByTypeUpdate]
    (
     @patient_id UNIQUEIDENTIFIER,
     @type INT,
     @seq_num_after BIGINT,
     @dateAfter BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @l_dateAfter DATETIME= [dbo].[fnFileTimeToDateTime](@dateAfter);

    (SELECT
        [RESULT].[result_value] AS [VALUE],
        CAST(NULL AS DATETIME) AS [RESULT_TIME],
        [RESULT].[Sequence] AS [SEQ_NUM],
        [RESULT].[result_ft] AS [RESULT_FILE_TIME]
     FROM
        [dbo].[int_result] AS [RESULT]
        INNER JOIN [dbo].[int_misc_code] AS [CODE] ON [RESULT].[test_cid] = [CODE].[code_id]
     WHERE
        ([RESULT].[patient_id] = @patient_id)
        AND ([CODE].[code_id] = @type)
        AND ([RESULT].[Sequence] > @seq_num_after)
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
        AND ([TimestampUTC] > @l_dateAfter)
    )
    ORDER  BY
        RESULT_FILE_TIME ASC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsByTypeUpdate';

