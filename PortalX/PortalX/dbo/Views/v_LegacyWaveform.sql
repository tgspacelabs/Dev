CREATE VIEW [dbo].[v_LegacyWaveform]
WITH SCHEMABINDING
AS
SELECT
    [wd].[Id],
    [wd].[SampleCount],
    [vwsr].[TypeName],
    [wd].[TypeId],
    [wd].[Samples] AS [WaveformData],
    [ts].[TopicTypeId],
    [wd].[TopicSessionId],
    [ts].[DeviceSessionId],
    [ts].[BeginTimeUTC] AS [SessionBeginUTC],
    [wd].[StartTimeUTC] AS [TimeStampBeginUTC],
    [wd].[EndTimeUTC] AS [TimeStampEndUTC],
    [FileTimeStampBeginUTC].[FileTime] AS [FileTimeStampBeginUTC],
    [FileTimeStampEndUTC].[FileTime] AS [FileTimeStampEndUTC],
    [vwsr].[SampleRate],
    [vpts].[PatientId],
    [ts].[TopicInstanceId],
    CASE
        WHEN [wd].[Compressed] = 0
            THEN
            NULL
        ELSE
            'WCTZLIB'
    END AS [CompressMethod]
FROM [dbo].[WaveformData] AS [wd]
    INNER JOIN [dbo].[v_WaveformSampleRate] AS [vwsr]
        ON [vwsr].[FeedTypeId] = [wd].[TypeId]
    INNER JOIN [dbo].[TopicSessions] AS [ts]
        ON [ts].[Id] = [wd].[TopicSessionId]
    INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts]
        ON [vpts].[TopicSessionId] = [ts].[Id]
    CROSS APPLY [dbo].[fntDateTimeToFileTime]([wd].[StartTimeUTC]) AS [FileTimeStampBeginUTC]
    CROSS APPLY [dbo].[fntDateTimeToFileTime]([wd].[EndTimeUTC]) AS [FileTimeStampEndUTC];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_LegacyWaveform';

