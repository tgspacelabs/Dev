CREATE PROCEDURE [dbo].[GetETEventsByType]
    (
    @patient_id UNIQUEIDENTIFIER,
    @Category INT,
    @Type INT,
    @StartTime BIGINT,
    @EndTime BIGINT)
AS
BEGIN
    SELECT DISTINCT
           [ev].[CategoryValue] AS [CATEGORY_VALUE],
           [ev].[Type],
           [ev].[Subtype],
           [ev].[Value1],
           [ev].[Value2],
           [ev].[Status] AS [STATUS_VALUE],
           [ev].[Valid_Leads] AS [LEADS],
           [FT_TIME].[FileTime] AS [FT_TIME],
           [pts].[PatientId] AS [patient_id]
    FROM [dbo].[EventsData] AS [ev]
        INNER JOIN [dbo].[TopicSessions] AS [ts]
            ON [ts].[Id] = [ev].[TopicSessionId]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [pts]
            ON [ts].[Id] = [pts].[TopicSessionId]
        CROSS APPLY [dbo].[fntDateTimeToFileTime]([ev].[TimestampUTC]) AS [FT_TIME]
    WHERE [pts].[PatientId] = @patient_id
          AND [ev].[CategoryValue] = @Category
          AND [ev].[Type] = @Type
          AND [FT_TIME].[FileTime] >= @StartTime
          AND [FT_TIME].[FileTime] <= @EndTime
    ORDER BY [FT_TIME];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETEventsByType';

