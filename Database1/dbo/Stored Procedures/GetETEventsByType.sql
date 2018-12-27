CREATE PROCEDURE [dbo].[GetETEventsByType]
    (
     @patient_id UNIQUEIDENTIFIER,
     @Category INT,
     @Type INT,
     @StartTime BIGINT,
     @EndTime BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        [ev].[Id] AS [ID],
        [ev].[CategoryValue] AS [CATEGORY_VALUE],
        [ev].[Type] AS [TYPE],
        [ev].[Subtype] AS [SUBTYPE],
        [ev].[Value1] AS [VALUE1],
        [ev].[Value2] AS [VALUE2],
        [ev].[status] AS [STATUS_VALUE],
        [ev].[valid_leads] AS [LEADS],
        [dbo].[fnDateTimeToFileTime]([ev].[TimeStampUTC]) AS [FT_TIME],
        [pts].[PatientId] AS [PATIENT_ID]
    FROM
        [dbo].[EventsData] AS [ev]
        INNER JOIN [dbo].[TopicSessions] AS [ts] ON [ev].[TopicSessionId] = [ts].[Id] 
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [pts] ON [ts].[Id] = [pts].[TopicSessionId]
    WHERE
        [pts].[PatientId] = @patient_id
        AND [ev].[CategoryValue] = @Category
        AND [TYPE] = @Type
        AND [dbo].[fnDateTimeToFileTime]([ev].[TimeStampUTC]) >= @StartTime
        AND [dbo].[fnDateTimeToFileTime]([ev].[TimeStampUTC]) <= @EndTime
    ORDER BY
        [FT_TIME];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETEventsByType';

