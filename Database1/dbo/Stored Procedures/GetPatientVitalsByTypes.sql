
CREATE PROCEDURE [dbo].[GetPatientVitalsByTypes]
    (
     @patient_id UNIQUEIDENTIFIER,
     @types [dbo].[VitalType] READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Result].[result_value] AS [VALUE],
        [Result].[obs_start_dt] AS [RESULT_TIME],
        [Result].[Sequence] AS [SEQ_NUM],
        [Result].[result_ft] AS [RESULT_FILE_TIME],
        [Code].[code] AS [GDS_CODE]
    FROM
        [dbo].[int_result] AS [Result]
        INNER JOIN [dbo].[int_misc_code] AS [Code] ON [Result].[test_cid] = [Code].[code_id]
    WHERE
        [Result].[patient_id] = @patient_id
        AND [Code].[code] IN (SELECT
                                [GdsCode]
                              FROM
                                @types)
    UNION ALL
    SELECT
        [Result].[ResultValue] AS [VALUE],
        CAST(NULL AS DATETIME) AS [RESULT_TIME],
        ROW_NUMBER() OVER (ORDER BY [Result].[GdsCode], [Result].[DateTimeStampUTC]) AS [SEQ_NUM],
        [dbo].[fnDateTimeToFileTime]([Result].[DateTimeStampUTC]) AS [RESULT_FILE_TIME],
        [Result].[GdsCode] AS [GDS_CODE]
    FROM
        [dbo].[v_VitalsData] [Result]
    WHERE
        [Result].[TopicSessionId] IN (SELECT
                                        [TopicSessionId]
                                      FROM
                                        [dbo].[v_PatientTopicSessions]
                                      WHERE
                                        [PatientId] = @patient_id)
        AND [Result].[GdsCode] IN (SELECT
                                    [GdsCode]
                                   FROM
                                    @types)
    ORDER BY
        [RESULT_FILE_TIME] ASC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsByTypes';

