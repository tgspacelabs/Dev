CREATE PROCEDURE [dbo].[GetPatientVitalsByTypeUpdate]
    (
    @patient_id UNIQUEIDENTIFIER,
    @type INT,
    @seq_num_after BIGINT,
    @dateAfter BIGINT)
AS
BEGIN
    DECLARE @l_dateAfter DATETIME = [dbo].[fnFileTimeToDateTime](@dateAfter);

    SELECT
        [RESULT].[result_value] AS [VALUE],
        CAST(NULL AS DATETIME) AS [RESULT_TIME],
        [RESULT].[Sequence] AS [SEQ_NUM],
        [RESULT].[result_ft] AS [RESULT_FILE_TIME],
        CAST(1 AS BIT) AS [IS_RESULT_LOCALIZED]
    FROM [dbo].[int_result] AS [RESULT]
        INNER JOIN [dbo].[int_misc_code] AS [CODE]
            ON [RESULT].[test_cid] = [CODE].[code_id]
    WHERE [RESULT].[patient_id] = @patient_id
          AND [CODE].[code_id] = @type
          AND [RESULT].[Sequence] > @seq_num_after

    UNION ALL

    SELECT
        [vd].[Value] AS [VALUE],
        CAST(NULL AS DATETIME) AS [RESULT_TIME],
        0 AS [SEQ_NUM],
        [RESULT_FILE_TIME].[FileTime] AS [RESULT_FILE_TIME],
        CAST(0 AS BIT) AS [IS_RESULT_LOCALIZED]
    FROM [dbo].[VitalsData] AS [vd]
        INNER JOIN [dbo].[GdsCodeMap] AS [gcm]
            ON [gcm].[CodeId] = @type
               AND [gcm].[FeedTypeId] = [vd].[FeedTypeId]
               AND [gcm].[Name] = [vd].[Name]
        INNER JOIN [dbo].[TopicSessions] AS [ts]
            ON [ts].[Id] = [vd].[TopicSessionId]
        CROSS APPLY [dbo].[fntDateTimeToFileTime]([vd].[TimestampUTC]) AS [RESULT_FILE_TIME]
    WHERE [ts].[PatientSessionId] IN (SELECT [psm].[PatientSessionId]
                                      FROM [dbo].[PatientSessionsMap] AS [psm]
                                          INNER JOIN (SELECT MAX([psm2].[Sequence]) AS [MaxSeq]
                                                      FROM [dbo].[PatientSessionsMap] AS [psm2]
                                                      GROUP BY [psm2].[PatientSessionId]) AS [PatientSessionMaxSeq]
                                              ON [psm].[Sequence] = [PatientSessionMaxSeq].[MaxSeq]
                                      WHERE [psm].[PatientId] = @patient_id)
          AND [vd].[TimestampUTC] > @l_dateAfter
    ORDER BY [RESULT_FILE_TIME] ASC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Return the patients'' vitals by type after sequence number and after date.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsByTypeUpdate';

