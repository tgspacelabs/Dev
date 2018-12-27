CREATE TABLE [dbo].[MetaData] (
    [Id]               BIGINT NOT NULL,
    [Name]             VARCHAR (50)     NOT NULL,
    [Value]            VARCHAR (MAX)    NOT NULL,
    [IsLookUp]         BIT              NULL,
    [MetaDataId]       BIGINT NULL,
    [TopicTypeId]      BIGINT NULL,
    [EntityName]       VARCHAR (50)     NULL,
    [EntityMemberName] VARCHAR (50)     NULL,
    [DisplayOnly]      BIT              NOT NULL,
    [TypeId]           BIGINT NOT NULL,
    CONSTRAINT [PK_MetaData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE CLUSTERED INDEX [CL_MetaData_Name_DisplayOnly_MetaDataId]
    ON [dbo].[MetaData]([Name] ASC, [DisplayOnly] ASC, [MetaDataId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId]
    ON [dbo].[MetaData]([MetaDataId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId_Name_TypeId_TopicTypeId_DisplayOnly_Id]
    ON [dbo].[MetaData]([MetaDataId] ASC, [Name] ASC, [TypeId] ASC, [TopicTypeId] ASC, [DisplayOnly] ASC, [Id] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_DisplayOnly_MetaDataId_Id_TypeId_Name]
    ON [dbo].[MetaData]([DisplayOnly] ASC, [MetaDataId] ASC, [Id] ASC, [TypeId] ASC, [Name] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_TypeId_Id_TopicTypeId_DisplayOnly_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [TypeId] ASC, [Id] ASC, [TopicTypeId] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_TopicTypeId_EntityName_DisplayOnly_Id_EntityMemberName_TypeId_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [TopicTypeId] ASC, [EntityName] ASC, [DisplayOnly] ASC, [Id] ASC, [EntityMemberName] ASC, [TypeId] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<Table description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MetaData';

