
CREATE VIEW [dbo].[v_WaveformSampleRate]
AS
  SELECT distinct TypeId as FeedTypeId, Value as SampleRate, EntityName as TypeName
  FROM [dbo].[MetaData]
  where Name='SampleRate'

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Gets the waveform sample rate.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_WaveformSampleRate';

