CREATE TABLE [dbo].[TopicType] (
    [TopicTypeID]     INT            NOT NULL,
    [Name]            VARCHAR (50)   NOT NULL,
    [BaseID]          INT            NULL,
    [Comment]         NVARCHAR (250) NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_TopicType_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TopicType_TopicTypeID] PRIMARY KEY CLUSTERED ([TopicTypeID] ASC)
);

