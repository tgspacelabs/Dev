
/*To get the waveforms for the Alarm in CEI*/
CREATE PROCEDURE [dbo].[usp_CEI_GetAlarmWaveform] 
        (            
              @patientId UNIQUEIDENTIFIER,
              @channeltypeId UNIQUEIDENTIFIER,
              @startDateTimeUTC datetime,
              @endDateTimeUTC datetime
       ) 
AS
BEGIN  
SELECT 
		 [StartTimeUTC] AS [START_DT_UTC]
		,[EndTimeUTC] AS [END_DT_UTC]
		,[Samples] AS [WAVEFORM_DATA]
		FROM [dbo].[WaveformLiveData]
		WHERE [WaveformLiveData].[TopicInstanceId] IN
		(
			SELECT [TopicInstanceId]
			FROM [dbo].[v_PatientTopicSessions]
			INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id]=[TopicSessionId]
			WHERE [PatientId] = @patientId
		)
		AND [WaveformLiveData].TypeId = @channeltypeId
		AND [StartTimeUTC] <= @endDateTimeUTC
		AND	@startDateTimeUTC <= [EndTimeUTC]
		ORDER BY [StartTimeUTC] ASC
END


