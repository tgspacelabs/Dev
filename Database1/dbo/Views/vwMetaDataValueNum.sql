
CREATE VIEW [dbo].[vwMetaDataValueNum] 
WITH SCHEMABINDING
AS 
SELECT 
    [Id]
    ,[Name]
    ,[Value]
    ,[IsLookUp]
    ,[MetaDataId]
    ,[TopicTypeId]
    ,[EntityName]
    ,[EntityMemberName]
    ,[DisplayOnly]
    ,[TypeId]
    ,[ValueNum] = 
        CASE ISNUMERIC([Value]) 
            WHEN 1 THEN CAST([Value] AS DECIMAL(18, 6)) 
            ELSE NULL 
        END
FROM [dbo].[MetaData] 

GO
CREATE UNIQUE CLUSTERED INDEX [IX_vwMetaDataValueNum_Id]
    ON [dbo].[vwMetaDataValueNum]([Id] ASC);

