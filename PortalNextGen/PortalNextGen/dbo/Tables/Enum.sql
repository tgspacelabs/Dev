CREATE TABLE [dbo].[Enum] (
    [EnumID]          INT            IDENTITY (1, 1) NOT NULL,
    [GroupID]         INT            NOT NULL,
    [Name]            VARCHAR (50)   NOT NULL,
    [Value]           INT            NOT NULL,
    [Comment]         NVARCHAR (250) NOT NULL,
    [TopicTypeID]     INT            NULL,
    [GroupName]       VARCHAR (50)   NULL,
    [MetadataID]      INT            NOT NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_Enum_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Enum_EnumID] PRIMARY KEY CLUSTERED ([EnumID] ASC),
    CONSTRAINT [FK_Enum_TopicType_TopicTypeID] FOREIGN KEY ([TopicTypeID]) REFERENCES [dbo].[TopicType] ([TopicTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_Enum_GroupID_Name_Value]
    ON [dbo].[Enum]([GroupID] ASC, [Name] ASC, [Value] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Enum_TopicType_TopicTypeID]
    ON [dbo].[Enum]([TopicTypeID] ASC);

