

CREATE VIEW [dbo].[v_LegacyWaveform]
AS
SELECT  WaveformData.Id,
        WaveformData.SampleCount,
        v_WaveformSampleRate.TypeName,
        WaveformData.TypeId,
        WaveformData.Samples as WaveformData,
        TopicSessions.TopicTypeId,
        WaveformData.TopicSessionId,
        TopicSessions.DeviceSessionId,
        TopicSessions.BeginTimeUTC AS [SessionBeginUTC],
        WaveformData.StartTimeUTC as TimeStampBeginUTC,
        WaveformData.EndTimeUTC as TimeStampEndUTC,
        dbo.fnDateTimeToFileTime(WaveformData.StartTimeUTC) as FileTimeStampBeginUTC,
        dbo.fnDateTimeToFileTime(WaveformData.EndTimeUTC) as FileTimeStampEndUTC,
        v_WaveformSampleRate.SampleRate,
        v_PatientTopicSessions.PatientId,
        TopicSessions.TopicInstanceId,
        CASE WHEN WaveformData.Compressed = 0 THEN NULL ELSE 'WCTZLIB' END  AS CompressMethod
 FROM WaveformData 
        INNER JOIN v_WaveformSampleRate ON v_WaveformSampleRate.FeedTypeId = WaveformData.TypeId
        INNER JOIN TopicSessions ON TopicSessions.Id = WaveformData.TopicSessionId
        INNER JOIN v_PatientTopicSessions ON v_PatientTopicSessions.TopicSessionId = TopicSessions.Id
