
CREATE VIEW [dbo].[v_FeedGdsCodes]
AS
SELECT distinct TypeId as FeedTypeId, Value as GdsCode
  FROM [dbo].[v_MetaData]
  where Name='GdsCode'

