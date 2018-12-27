

/****** Object:  StoredProcedure [dbo].[usp_PM_GetPatientWaveformData]    Script Date: 08/25/2014 12:00:12 ******/
CREATE PROCEDURE [dbo].[usp_PM_GetPatientWaveformData]
    @alarmId UNIQUEIDENTIFIER,
    @numberOfSeconds INT = -1,
    @locale NVARCHAR(2) = 'en'
AS
BEGIN
    SET NOCOUNT ON;

    IF @locale IS NULL
        OR @locale NOT IN ('de', 'en', 'es', 'fr', 'it', 'nl', 'pl', 'zh', 'cs', 'pt')
        SET @locale = 'en';

    SET NOCOUNT ON;

    DECLARE @deviceSessionId UNIQUEIDENTIFIER;
    DECLARE @alarmStartTimeUTC DATETIME;
    DECLARE @alarmEndTimeUTC DATETIME;

    DECLARE @Waveforms TABLE
        (
         [ReportStartTimeUTC] DATETIME,
         [ReportEndTimeUTC] DATETIME,
         [WaveformStartTimeUTC] DATETIME,
         [WaveformEndTimeUTC] DATETIME,
         [SampleRate] INT,
         [WaveformData] VARBINARY(MAX),
         [ChannelCode] INT,
         [WaveformLabel] NVARCHAR(250),
         [Compressed] INT
        );

    DECLARE @paddingSeconds INT = 6; -- The number of seconds of waveform/vitals data before and after an alarm that we want to display/capture


    SELECT
        @deviceSessionId = [DeviceSessionId],
        @alarmStartTimeUTC = DATEADD(SECOND, -@paddingSeconds, [AlarmStartTimeUTC]),
        @alarmEndTimeUTC = DATEADD(SECOND, @paddingSeconds, [AlarmEndTimeUTC])
    FROM
        [dbo].[int_print_job_et_alarm]
    WHERE
        [AlarmId] = @alarmId;
	
    IF (@numberOfSeconds > 0)
        SET @alarmEndTimeUTC = DATEADD(SECOND, @numberOfSeconds, @alarmStartTimeUTC);

    IF (@alarmEndTimeUTC IS NULL)
        SET @alarmEndTimeUTC = GETUTCDATE();

    INSERT  INTO @Waveforms
    SELECT DISTINCT
        @alarmStartTimeUTC AS [ReportStartTimeUTC],
        @alarmEndTimeUTC AS [ReportEndTimeUTC],
        [Waveforms].[StartTimeUTC] AS [WaveformStartTimeUTC],
        [Waveforms].[EndTimeUTC] AS [WaveformEndTimeUTC],
        [Waveforms].[SampleRate],
        [Waveforms].[WaveformData],
        [Waveforms].[ChannelCode],
        [Value] AS [WaveformLabel],
        [Waveforms].[Compressed]
    FROM
        (SELECT
            [StartTimeUTC],
            [EndTimeUTC],
            [SampleRate],
            [WaveformData],
            [ChannelCode],
            [CdiLabel],
            [Compressed] = 1
         FROM
            [dbo].[int_print_job_et_waveform]
         WHERE
            [DeviceSessionId] = @deviceSessionId
            AND [StartTimeUTC] < @alarmEndTimeUTC
         UNION ALL
         SELECT
            [StartTimeUTC] AS [StartTimeUTC],
            [WaveformData].[EndTimeUTC] AS [EndTimeUTC],
            [SampleRate] AS [SampleRate],
            [Samples] AS [WaveformData],
            [ChannelCode] AS [ChannelCode],
            [Label] AS [CdiLabel],
            [Compressed]
         FROM
            [dbo].[WaveformData]
            INNER JOIN [dbo].[TopicSessions] ON [TopicSessionId] = [TopicSessions].[Id]
            INNER JOIN [dbo].[TopicFeedTypes] ON [FeedTypeId] = [TypeId]
         WHERE
            [DeviceSessionId] = @deviceSessionId
            AND [StartTimeUTC] < @alarmEndTimeUTC
        ) AS [Waveforms]
        INNER JOIN [dbo].[ResourceStrings] ON [Waveforms].[CdiLabel] = [Name]
                                      AND [Locale] = @locale
    WHERE
        [Waveforms].[EndTimeUTC] > @alarmStartTimeUTC;

    DECLARE @LatestSample DATETIME;

    SELECT
        @LatestSample = MAX([WaveformEndTimeUTC])
    FROM
        @Waveforms;

    IF (@alarmEndTimeUTC > @LatestSample)
    BEGIN
        INSERT  INTO @Waveforms
        SELECT DISTINCT
            @alarmStartTimeUTC AS [ReportStartTimeUTC],
            @alarmEndTimeUTC AS [ReportEndTimeUTC],
            [Waveforms].[StartTimeUTC] AS [WaveformStartTimeUTC],
            [Waveforms].[EndTimeUTC] AS [WaveformEndTimeUTC],
            [Waveforms].[SampleRate],
            [Waveforms].[WaveformData],
            [Waveforms].[ChannelCode],
            [Value] AS [WaveformLabel],
            [Waveforms].[Compressed]
        FROM
            (SELECT
                [DeviceSessionId],
                [StartTimeUTC] AS [StartTimeUTC],
                [WaveformLiveData].[EndTimeUTC] AS [EndTimeUTC],
                [SampleRate] AS [SampleRate],
                [Samples] AS [WaveformData],
                [ChannelCode] AS [ChannelCode],
                [Label] AS [CdiLabel],
                [Compressed] = 0
             FROM
                [dbo].[WaveformLiveData]
                INNER JOIN [dbo].[TopicSessions] ON [WaveformLiveData].[TopicInstanceId] = [TopicSessions].[TopicInstanceId]
                INNER JOIN [dbo].[TopicFeedTypes] ON [FeedTypeId] = [TypeId]
             WHERE
                [DeviceSessionId] = @deviceSessionId
                AND [StartTimeUTC] < @alarmEndTimeUTC
            ) AS [Waveforms]
            INNER JOIN [dbo].[ResourceStrings] ON [Waveforms].[CdiLabel] = [Name]
                                          AND [Locale] = @locale
        WHERE
            [Waveforms].[EndTimeUTC] > @LatestSample;
    END;

    SELECT
        [ReportStartTimeUTC],
        [ReportEndTimeUTC],
        [WaveformStartTimeUTC],
        [WaveformEndTimeUTC],
        [SampleRate],
        [WaveformData],
        [ChannelCode],
        [WaveformLabel],
        [Compressed]
    FROM
        @Waveforms
    ORDER BY
        [ChannelCode],
        [WaveformStartTimeUTC] ASC;
	
    SET NOCOUNT OFF;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PM_GetPatientWaveformData';

