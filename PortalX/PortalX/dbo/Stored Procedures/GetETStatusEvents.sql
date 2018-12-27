CREATE PROCEDURE [dbo].[GetETStatusEvents]
    (@patient_id UNIQUEIDENTIFIER)
AS
BEGIN
    SELECT
        [ed].[Subtype] AS [Subtype],
        [ed].[Value1] AS [VALUE1],
        [ed].[Status] AS [STATUS_VALUE],
        [ed].[Valid_Leads] AS [LEADS],
        [FT_TIME].[FileTime] AS [FT_TIME],
        @patient_id AS [patient_id], -- Why are we returning the patient ID when it was passed in as a parameter?
        ISNULL([MAX_FT_TIME].[FileTime], -1) AS [MAX_FT_TIME]
    FROM [dbo].[EventsData] AS [ed]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts]
            ON [vpts].[TopicSessionId] = [ed].[TopicSessionId]
        INNER JOIN [dbo].[TopicSessions] AS [ts]
            ON [ts].[Id] = [ed].[TopicSessionId]
        CROSS APPLY [dbo].[fntDateTimeToFileTime]([ed].[TimestampUTC]) AS [FT_TIME]
        CROSS APPLY [dbo].[fntDateTimeToFileTime]([ts].[EndTimeUTC]) AS [MAX_FT_TIME]
    WHERE [vpts].[PatientId] = @patient_id
          AND [ed].[CategoryValue] = 2
          AND [ed].[Type] = 1
    ORDER BY [FT_TIME].[FileTime];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get ET status events.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetETStatusEvents';

