
CREATE PROCEDURE [dbo].[usp_SaveWaveformLiveDataSet]
	(@waveformData [dbo].[WaveformDataType] READONLY)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO [dbo].[WaveformLiveData]
	([Id],[SampleCount],[TypeName],[TypeId],[Samples],[TopicInstanceId],StartTimeUTC,EndTimeUTC,[Mod4])
	SELECT [WF].[Id], [SampleCount], [TypeName], [TypeId], [Samples], [TopicInstanceId], WF.StartTimeUTC, WF.EndTimeUTC,
	[Mod4]=DATEPART(minute,[WF].[StartTimeUTC])%4
	FROM @waveformData AS [WF] JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id]=[WF].[TopicSessionId]

END

