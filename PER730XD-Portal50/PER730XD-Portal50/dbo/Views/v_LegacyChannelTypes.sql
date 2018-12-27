


CREATE VIEW [dbo].[v_LegacyChannelTypes]
AS
SELECT     
                  ISNULL(MDMax.TypeId, dbo.TopicTypes.Id) ChannelTypeId,
                  dbo.TopicTypes.Id as TopicTypeId, 
                  dbo.TopicTypes.Name as TopicName, 
                  MDLabel.Value as 'CdiLabel',
                  MDMax.PairEntityName as 'TypeName',
                  MDMax.TypeId,
                  --MDMax.PairValue AS 'MaxValue', --MaxValue in SalishMetadata is 4095 coming from ushort exactly as received from the monitor, which is different from what ICS needs
                  --MDMin.PairValue AS 'MinValue', --MinValue in SalishMetadata is 0-based, which is coming from ushort exactly as received from the monitor, which is different from what ICS needs
                  MDSampleRate.PairValue as 'SampleRate',
                  MDChannelCode.Value as ChannelCode,
                  int_channel_type.label
                  
                  
FROM         dbo.TopicTypes 

             inner join
                          (SELECT     Value, TopicTypeId, Name, EntityName, TypeId
                            FROM      [dbo].[v_MetaData] meta
                            WHERE     meta.Name = 'ChannelCode') AS MDChannelCode ON 
                                                MDChannelCode.TopicTypeId = TopicTypes.Id 
                                                
             left join
                          (SELECT     Value, TypeId
                            FROM      [dbo].[v_MetaData]
                            WHERE     Name = 'Label') AS MDLabel ON MDLabel.TypeId = MDChannelCode.TypeId
             left join

                          (SELECT     PairValue, TopicTypeId, PairName, PairEntityName, PairEntityMember, PairMetaDataId, EntityName, TypeId
                            FROM      [dbo].[v_MetaData]
                            WHERE     (PairName = 'ScaledMax') AND DisplayOnly = '0') AS MDMax ON MDLabel.TypeId = MDMax.TypeId 

                  left join
                          (SELECT     PairValue, PairMetaDataId
                            FROM      [dbo].[v_MetaData] meta
                            WHERE     meta.PairName = 'ScaledMin') AS MDMin ON MDMin.PairMetaDataId = MDMax.PairMetaDataId

                  left join
                          (SELECT     PairValue, PairMetaDataId
                            FROM      [dbo].[v_MetaData] meta
                            WHERE     meta.PairName = 'SampleRate') AS MDSampleRate ON MDSampleRate.PairMetaDataId = MDMax.PairMetaDataId
            left outer join int_channel_type on int_channel_type.channel_code = CAST(MDChannelCode.Value AS INT) 

