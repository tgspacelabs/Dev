
CREATE PROCEDURE [dbo].[usp_SaveWaveformDataSet]
	(@waveformData [dbo].[WaveformDataType] READONLY)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO dbo.WaveformData
	(Id, SampleCount, TypeName, TypeId, Samples, Compressed, TopicSessionId, StartTimeUTC, EndTimeUTC)
	SELECT Id, SampleCount, TypeName, TypeId, Samples, Compressed, TopicSessionId, StartTimeUTC, EndTimeUTC
	FROM @waveformData

END
