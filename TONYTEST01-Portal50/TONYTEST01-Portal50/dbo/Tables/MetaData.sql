CREATE TABLE [dbo].[MetaData] (
    [Id]               UNIQUEIDENTIFIER NOT NULL,
    [Name]             VARCHAR (50)     NOT NULL,
    [Value]            VARCHAR (MAX)    NOT NULL,
    [IsLookUp]         BIT              NULL,
    [MetaDataId]       UNIQUEIDENTIFIER NULL,
    [TopicTypeId]      UNIQUEIDENTIFIER NULL,
    [EntityName]       VARCHAR (50)     NULL,
    [EntityMemberName] VARCHAR (50)     NULL,
    [DisplayOnly]      BIT              NOT NULL,
    [TypeId]           UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_MetaData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE CLUSTERED INDEX [IX_MetaData_Name_DisplayOnly_MetaDataId]
    ON [dbo].[MetaData]([Name] ASC, [DisplayOnly] ASC, [MetaDataId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_Id_TypeId]
    ON [dbo].[MetaData]([Name] ASC, [Id] ASC, [TypeId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_EntityMemberName]
    ON [dbo].[MetaData]([EntityMemberName] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_EntityName]
    ON [dbo].[MetaData]([EntityName] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_IsLookUp]
    ON [dbo].[MetaData]([IsLookUp] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId]
    ON [dbo].[MetaData]([MetaDataId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name]
    ON [dbo].[MetaData]([Name] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC)
    INCLUDE([Value], [EntityMemberName], [TypeId]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_Id_EntityMemberName_TypeId_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [Id] ASC, [EntityMemberName] ASC, [TypeId] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId_DisplayOnly_TypeId_Id]
    ON [dbo].[MetaData]([MetaDataId] ASC, [DisplayOnly] ASC, [TypeId] ASC)
    INCLUDE([Id]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId_DisplayOnly_TypeId_Id_Name]
    ON [dbo].[MetaData]([MetaDataId] ASC, [DisplayOnly] ASC, [TypeId] ASC, [Id] ASC, [Name] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId_Id_TypeId_EntityMemberName_Name]
    ON [dbo].[MetaData]([MetaDataId] ASC, [Id] ASC, [TypeId] ASC, [EntityMemberName] ASC, [Name] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId_Name_Value]
    ON [dbo].[MetaData]([MetaDataId] ASC, [Name] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId_Name_TypeId_TopicTypeId_DisplayOnly_Id]
    ON [dbo].[MetaData]([MetaDataId] ASC, [Name] ASC, [TypeId] ASC, [TopicTypeId] ASC, [DisplayOnly] ASC, [Id] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_MetaDataId_Name_TypeId_Id_TopicTypeId_DisplayOnly_Value]
    ON [dbo].[MetaData]([MetaDataId] ASC, [Name] ASC, [TypeId] ASC, [Id] ASC, [TopicTypeId] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_Id_TypeId_MetaDataId_Value]
    ON [dbo].[MetaData]([Name] ASC, [Id] ASC, [TypeId] ASC, [MetaDataId] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_TypeId_EntityMemberName_Id_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [TypeId] ASC, [EntityMemberName] ASC, [Id] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Id_Name_TypeId_MetaDataId_TopicTypeId_DisplayOnly_Value]
    ON [dbo].[MetaData]([Id] ASC, [Name] ASC, [TypeId] ASC, [MetaDataId] ASC, [TopicTypeId] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_TypeId_Id_Name_MetaDataId_TopicTypeId_DisplayOnly_Value]
    ON [dbo].[MetaData]([TypeId] ASC, [Id] ASC, [Name] ASC, [MetaDataId] ASC, [TopicTypeId] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_TypeId_Name_MetaDataId_Id_DisplayOnly_TopicTypeId_Value]
    ON [dbo].[MetaData]([TypeId] ASC, [Name] ASC, [MetaDataId] ASC, [Id] ASC, [DisplayOnly] ASC, [TopicTypeId] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Id_TypeId_TopicTypeId_Name_DisplayOnly_Value]
    ON [dbo].[MetaData]([MetaDataId] ASC, [Id] ASC, [TypeId] ASC, [TopicTypeId] ASC, [Name] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_Id_TypeId_DisplayOnly_TopicTypeId_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [Id] ASC, [TypeId] ASC, [DisplayOnly] ASC, [TopicTypeId] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_TypeId]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [TypeId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_DisplayOnly_Id_TopicTypeId_TypeId_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [DisplayOnly] ASC, [Id] ASC, [TopicTypeId] ASC, [TypeId] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Id_Name_MetaDataId_TypeId_EntityMemberName_DisplayOnly_Value]
    ON [dbo].[MetaData]([Id] ASC, [Name] ASC, [MetaDataId] ASC, [TypeId] ASC, [EntityMemberName] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_TypeId_EntityMemberName_Id_DisplayOnly_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [TypeId] ASC, [EntityMemberName] ASC, [Id] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_TopicTypeId_Name_MetaDataId_Id_TypeId]
    ON [dbo].[MetaData]([TopicTypeId] ASC, [Name] ASC, [MetaDataId] ASC, [Id] ASC, [TypeId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_TypeId_DisplayOnly_MetaDataId_Id]
    ON [dbo].[MetaData]([TypeId] ASC, [DisplayOnly] ASC, [MetaDataId] ASC, [Id] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_TopicTypeId_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [TopicTypeId] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_DisplayOnly_MetaDataId_Id_TypeId_Name]
    ON [dbo].[MetaData]([DisplayOnly] ASC, [MetaDataId] ASC, [Id] ASC, [TypeId] ASC, [Name] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_EntityName_MetaDataId_Id_TopicTypeId_EntityMemberName]
    ON [dbo].[MetaData]([EntityName] ASC, [MetaDataId] ASC, [Id] ASC, [TopicTypeId] ASC, [EntityMemberName] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_TypeId_Id_TopicTypeId_DisplayOnly_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [TypeId] ASC, [Id] ASC, [TopicTypeId] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_TopicTypeId_Name_MetaDataId_Id_TypeId_DisplayOnly_Value]
    ON [dbo].[MetaData]([TopicTypeId] ASC, [Name] ASC, [MetaDataId] ASC, [Id] ASC, [TypeId] ASC, [DisplayOnly] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_MetaData_Name_MetaDataId_TopicTypeId_EntityName_DisplayOnly_Id_EntityMemberName_TypeId_Value]
    ON [dbo].[MetaData]([Name] ASC, [MetaDataId] ASC, [TopicTypeId] ASC, [EntityName] ASC, [DisplayOnly] ASC, [Id] ASC, [EntityMemberName] ASC, [TypeId] ASC)
    INCLUDE([Value]) WITH (FILLFACTOR = 100);

