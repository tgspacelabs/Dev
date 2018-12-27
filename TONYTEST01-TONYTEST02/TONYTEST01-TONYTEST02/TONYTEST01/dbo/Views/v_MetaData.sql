
CREATE VIEW [dbo].[v_MetaData]
AS
SELECT meta.[Id]
      ,meta.[Name]
      ,meta.[Value]
      ,meta.[TypeId]
      ,meta.[IsLookUp]
      ,meta.[TopicTypeId]
      ,meta.[EntityName]
      ,meta.[EntityMemberName]
      ,meta.[DisplayOnly]
      ,metaPairs.[Name] as PairName
      ,metaPairs.[Value] as PairValue
      ,metaPairs.[IsLookUp] as PairLookup
      ,metaPairs.[EntityName] as PairEntityName
      ,metaPairs.[EntityMemberName] as PairEntityMember
      ,metaPairs.MetaDataId as PairMetaDataId
      
  FROM [dbo].[MetaData] meta
  left outer join [dbo].[MetaData] metaPairs on metaPairs.MetaDataId = meta.Id
  where meta.MetaDataId is null

