
/* NEW STORED PROCEDURES FOR ET DATA */
CREATE PROCEDURE [dbo].[GetETBeatTimeLog]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [ed].[Type] AS [TYPE],
        [ed].[Subtype] AS [SUBTYPE],
        [ed].[Value1] AS [VALUE1],
        [ed].[Value2] AS [VALUE2],
        [ed].[status] AS [STATUS_VALUE],
        [ed].[valid_leads] AS [LEADS],
        [dbo].[fnDateTimeToFileTime]([ed].[TimeStampUTC]) AS [FT_TIME],
        @patient_id AS [PATIENT_ID]
    FROM
        [dbo].[EventsData] AS [ed]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts] ON [vpts].[TopicSessionId] = [ed].[TopicSessionId]
    WHERE
        [vpts].[PatientId] = @patient_id
        AND [ed].[CategoryValue] = 0
    ORDER BY
        [FT_TIME];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETBeatTimeLog';

