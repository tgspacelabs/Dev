

CREATE VIEW [dbo].[v_TopicTypes]
AS
SELECT     dbo.TopicTypes.Id, dbo.TopicTypes.Name, dbo.TopicTypes.BaseId, dbo.TopicTypes.Comment, MDLabel.Value AS 'Label'
FROM         dbo.TopicTypes LEFT OUTER JOIN
                          (SELECT     Value, TopicTypeId, Name
                            FROM          dbo.MetaData
                            WHERE      (Name = 'Label') AND (EntityName IS NULL)) AS MDLabel ON MDLabel.TopicTypeId = dbo.TopicTypes.Id
