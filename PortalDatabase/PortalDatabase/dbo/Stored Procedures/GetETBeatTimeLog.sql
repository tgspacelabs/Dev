CREATE PROCEDURE [dbo].[GetETBeatTimeLog]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SELECT
        [ed].[Type] AS [TYPE],
        [ed].[Subtype] AS [Subtype],
        [ed].[Value1] AS [VALUE1],
        [ed].[Value2] AS [VALUE2],
        [ed].[Status] AS [STATUS_VALUE],
        [ed].[Valid_Leads] AS [LEADS],
        [TimestampUTCFileTime].[FileTime] AS [FT_TIME]
    FROM
        [dbo].[EventsData] AS [ed]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts]
            ON [vpts].[TopicSessionId] = [ed].[TopicSessionId]
        CROSS APPLY [dbo].[fntDateTimeToFileTime]([ed].[TimestampUTC]) AS [TimestampUTCFileTime]
    WHERE
        [vpts].[PatientId] = @patient_id
        AND [ed].[CategoryValue] = 0
    ORDER BY
        [ed].[TimestampUTC];
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get ET beat time log.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETBeatTimeLog';

