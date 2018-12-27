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
    SELECT DISTINCT
        [CategoryValue] AS [CATEGORY_VALUE],
        [Type] AS [TYPE],
        [Subtype] AS [Subtype],
        [Value1] AS [VALUE1],
        [Value2] AS [VALUE2],
        [Status] AS [STATUS_VALUE],
        [Valid_Leads] AS [LEADS],
        [dbo].[fnDateTimeToFileTime]([TimestampUTC]) AS [FT_TIME],
        [pts].[PatientId] AS [patient_id]
    FROM
        [dbo].[EventsData] AS [ev]
        INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [ev].[TopicSessionId]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [pts] ON [TopicSessions].[Id] = [pts].[TopicSessionId]
    WHERE
        [pts].[PatientId] = @patient_id
        AND [CategoryValue] = @Category
        AND [Type] = @Type
        AND ([dbo].[fnDateTimeToFileTime]([TimestampUTC]) >= @StartTime)
        AND ([dbo].[fnDateTimeToFileTime]([TimestampUTC]) <= @EndTime)
    ORDER BY
        [FT_TIME];
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETEventsByType';

