
CREATE VIEW [dbo].[v_StatusData]
WITH SCHEMABINDING
AS
SELECT
    [sd].[Id],
    [sd].[SetId],
    [sd].[Name],
    [sd].[Value] AS [ResultValue],
    [ts].[TopicTypeId],
    [ts].[Id] AS [TopicSessionId],
    [sds].[TimestampUTC] AS [DateTimeStampUTC],
    [DateTimeStamp].[LocalDateTime] AS [DateTimeStamp],
    [vpts].[PatientId] AS [PatientId],
    [FileDateTimeStamp].[FileTime] AS [FileDateTimeStamp],
    CASE [sd].[Name]
        WHEN 'lead1Index'
            THEN
            '2.1.2.0'
        WHEN 'lead2Index'
            THEN
            '2.2.2.0'
        ELSE
            [sd].[Name]
    END AS [GdsCode],
    [sds].[FeedTypeId] AS [FeedTypeId]
FROM [dbo].[StatusData] AS [sd]
    INNER JOIN [dbo].[StatusDataSets] AS [sds]
        ON [sd].[SetId] = [sds].[Id]
    INNER JOIN [dbo].[TopicSessions] AS [ts]
        ON [ts].[Id] = [sds].[TopicSessionId]
    INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts]
        ON [vpts].[TopicSessionId] = [ts].[Id]
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([sds].[TimestampUTC]) AS [DateTimeStamp]
    CROSS APPLY [dbo].[fntDateTimeToFileTime]([sds].[TimestampUTC]) AS [FileDateTimeStamp];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_StatusData';

