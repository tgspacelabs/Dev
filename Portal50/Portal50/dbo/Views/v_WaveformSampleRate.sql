
CREATE VIEW [dbo].[v_WaveformSampleRate]
AS
  SELECT distinct TypeId as FeedTypeId, Value as SampleRate, EntityName as TypeName
  FROM [dbo].[MetaData]
  where Name='SampleRate'
