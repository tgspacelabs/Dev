
CREATE VIEW [dbo].[WaveformLiveData]
	WITH SCHEMABINDING
AS
	SELECT [Id], [SampleCount], [TypeName], [TypeId], [Samples], [TopicInstanceId], [StartTimeUTC], [EndTimeUTC], [Mod4]
		FROM [dbo].[WaveformLiveData1]
UNION ALL
	SELECT [Id], [SampleCount], [TypeName], [TypeId], [Samples], [TopicInstanceId], [StartTimeUTC], [EndTimeUTC], [Mod4]
		FROM [dbo].[WaveformLiveData2]
UNION ALL
	SELECT [Id], [SampleCount], [TypeName], [TypeId], [Samples], [TopicInstanceId], [StartTimeUTC], [EndTimeUTC], [Mod4]
		FROM [dbo].[WaveformLiveData3]
UNION ALL
	SELECT [Id], [SampleCount], [TypeName], [TypeId], [Samples], [TopicInstanceId], [StartTimeUTC], [EndTimeUTC], [Mod4]
		FROM [dbo].[WaveformLiveData4]
