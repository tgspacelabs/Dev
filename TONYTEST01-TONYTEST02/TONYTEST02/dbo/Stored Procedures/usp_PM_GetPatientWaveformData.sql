
/****** Object:  StoredProcedure [dbo].[usp_PM_GetPatientWaveformData]    Script Date: 08/25/2014 12:00:12 ******/
CREATE PROCEDURE [dbo].[usp_PM_GetPatientWaveformData]
	@alarmId UNIQUEIDENTIFIER,
	@numberOfSeconds INT=-1,
	@locale NVARCHAR(2)='en'
AS

BEGIN
 
IF @locale IS NULL OR @locale NOT IN ('de', 'en', 'es', 'fr', 'it', 'nl', 'pl', 'zh', 'cs', 'pt')
	SET @locale = 'en'

	SET NOCOUNT ON;

	DECLARE @deviceSessionId UNIQUEIDENTIFIER
	DECLARE @alarmStartTimeUTC datetime
	DECLARE @alarmEndTimeUTC datetime

	DECLARE @Waveforms TABLE
	(
		ReportStartTimeUTC datetime,
		ReportEndTimeUTC datetime,
		WaveformStartTimeUTC datetime,
		WaveformEndTimeUTC datetime,
		SampleRate int,
		WaveformData varbinary(max),
		ChannelCode int,
		WaveformLabel NVARCHAR(250),
		Compressed int
	)

	DECLARE @paddingSeconds int = 6 -- The number of seconds of waveform/vitals data before and after an alarm that we want to display/capture


	SELECT @deviceSessionId = DeviceSessionId
		   , @alarmStartTimeUTC = DATEADD(SECOND, -@paddingSeconds, AlarmStartTimeUTC)
		   , @alarmEndTimeUTC = DATEADD(SECOND, @paddingSeconds, AlarmEndTimeUTC)
	FROM int_print_job_et_alarm
	WHERE AlarmId = @alarmId
	
	IF (@numberOfSeconds > 0)
		SET @alarmEndTimeUTC = DATEADD(SECOND, @numberOfSeconds, @alarmStartTimeUTC)

	IF (@alarmEndTimeUTC IS NULL)
		SET @alarmEndTimeUTC = GETUTCDATE()

	INSERT INTO @Waveforms
	SELECT DISTINCT @alarmStartTimeUTC AS ReportStartTimeUTC
					, @alarmEndTimeUTC AS ReportEndTimeUTC
					, StartTimeUTC AS WaveformStartTimeUTC
					, EndTimeUTC AS WaveformEndTimeUTC
					, SampleRate
					, WaveformData
					, ChannelCode
					, ResourceStrings.Value AS WaveformLabel
					, Compressed
	FROM (SELECT StartTimeUTC
				 , EndTimeUTC
				 , SampleRate
				 , WaveformData
				 , ChannelCode
				 , CdiLabel
				 , Compressed = 1
		  FROM int_print_job_et_waveform
		  WHERE DeviceSessionId = @deviceSessionId
				AND StartTimeUTC <  @alarmEndTimeUTC

		  UNION ALL

		  SELECT WaveformData.StartTimeUTC as StartTimeUTC
				 , WaveformData.EndTimeUTC as EndTimeUTC
				 , TopicFeedTypes.SampleRate as SampleRate
				 , WaveformData.Samples as WaveformData
				 , TopicFeedTypes.ChannelCode as ChannelCode
				 , TopicFeedTypes.Label as CdiLabel
				 , WaveformData.Compressed
		  FROM WaveformData
		  INNER JOIN TopicSessions ON WaveformData.TopicSessionId = TopicSessions.Id
		  INNER JOIN TopicFeedTypes ON [TopicFeedTypes].FeedTypeId  = WaveformData.TypeId 		  
		  WHERE TopicSessions.DeviceSessionId = @deviceSessionId AND WaveformData.StartTimeUTC <  @alarmEndTimeUTC
	) AS Waveforms
	INNER JOIN ResourceStrings ON CdiLabel = [ResourceStrings].Name AND Locale = @locale
	WHERE Waveforms.EndTimeUTC > @alarmStartTimeUTC

	DECLARE @LatestSample datetime

	SELECT @LatestSample = MAX(waveformEndTimeUTC) 
    FROM @Waveforms

	IF (@alarmEndTimeUTC > @LatestSample)
	BEGIN
		INSERT INTO @Waveforms
		SELECT DISTINCT @alarmStartTimeUTC AS ReportStartTimeUTC
						, @alarmEndTimeUTC AS ReportEndTimeUTC
						, StartTimeUTC AS WaveformStartTimeUTC
						, EndTimeUTC AS WaveformEndTimeUTC
						, SampleRate
						, WaveformData
						, ChannelCode
						, ResourceStrings.Value AS WaveformLabel
						, Compressed
						FROM (SELECT TopicSessions.DeviceSessionId
					 , WaveformLiveData.StartTimeUTC as StartTimeUTC
					 , WaveformLiveData.EndTimeUTC as EndTimeUTC
					 , TopicFeedTypes.SampleRate as SampleRate
					 , WaveformLiveData.Samples as WaveformData
					 , TopicFeedTypes.ChannelCode as ChannelCode
					 , TopicFeedTypes.Label as CdiLabel
					 , Compressed = 0
			  FROM WaveformLiveData
			  INNER JOIN TopicSessions ON WaveformLiveData.TopicInstanceId = TopicSessions.TopicInstanceId
			  INNER JOIN TopicFeedTypes ON [TopicFeedTypes].FeedTypeId  = WaveformLiveData.TypeId 				  
			  WHERE TopicSessions.DeviceSessionId = @deviceSessionId
					AND WaveformLiveData.StartTimeUTC <  @alarmEndTimeUTC
		) AS Waveforms
		INNER JOIN ResourceStrings ON CdiLabel = [ResourceStrings].Name AND Locale = @locale
		WHERE Waveforms.EndTimeUTC > @LatestSample
	END

	SELECT * FROM @Waveforms
	ORDER BY ChannelCode, WaveformStartTimeUTC asc
	
	SET NOCOUNT OFF;
END

