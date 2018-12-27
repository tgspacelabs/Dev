
CREATE VIEW [dbo].[v_LiveVitalsData]
WITH SCHEMABINDING
AS
SELECT
    [ld].[Name],
    [ld].[Value] AS [ResultValue],
    [ts].[TopicTypeId],
    [ts].[Id] AS [TopicSessionId],
    [vpts].[PatientId] AS [PatientId],
    [ts].[TopicInstanceId],
    CASE [ld].[Name]
        WHEN 'T1Value'
            THEN
            '4.6.' + CAST((1 + CAST([dbo].[fnZeroIfBigger]([vdt1].[Value], 32767) AS INT)) AS NVARCHAR(15)) + '.0'
        WHEN 'T2Value'
            THEN
            '4.7.' + CAST((1 + CAST([dbo].[fnZeroIfBigger]([vdt2].[Value], 32767) AS INT)) AS NVARCHAR(15)) + '.0'
        WHEN 'lead1Index'
            THEN
            '2.1.2.0'
        WHEN 'lead2Index'
            THEN
            '2.2.2.0'
        ELSE
            [GdsMetaData].[Value]
    END AS [GdsCode],
    [ld].[TimestampUTC] AS [DateTimeStampUTC],
    [DateTimeStamp].[LocalDateTime] AS [DateTimeStamp],
    [FileDateTimeStamp].[FileTime] AS [FileDateTimeStamp],
    [ld].[FeedTypeId]
FROM [dbo].[LiveData] AS [ld]
    INNER JOIN [dbo].[TopicSessions] AS [ts]
        ON [ts].[TopicInstanceId] = [ld].[TopicInstanceId]
           AND [ts].[EndTimeUTC] IS NULL
    INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts]
        ON [vpts].[TopicSessionId] = [ts].[Id]
    LEFT OUTER JOIN [dbo].[v_MetaData] AS [GdsMetaData]
        ON [GdsMetaData].[TypeId] = [ld].[FeedTypeId]
           AND [GdsMetaData].[EntityMemberName] = [ld].[Name]
           AND [GdsMetaData].[Name] = 'GdsCode'
    LEFT OUTER JOIN [dbo].[LiveData] AS [vdt1]
        ON [vdt1].[Id] = [vdt1].[Id]
           AND [vdt1].[Name] = 'T1Location'
    LEFT OUTER JOIN [dbo].[LiveData] AS [vdt2]
        ON [vdt1].[Id] = [vdt2].[Id]
           AND [vdt2].[Name] = 'T2Location'
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([ld].[TimestampUTC]) AS [DateTimeStamp]
    CROSS APPLY [dbo].[fntDateTimeToFileTime]([ld].[TimestampUTC]) AS [FileDateTimeStamp];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_LiveVitalsData';

