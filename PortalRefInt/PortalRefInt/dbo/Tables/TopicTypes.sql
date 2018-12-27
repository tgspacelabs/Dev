CREATE TABLE [dbo].[TopicTypes] (
    [Id]      BIGINT NOT NULL,
    [Name]    VARCHAR (50)     NOT NULL,
    [BaseId]  BIGINT NULL,
    [Comment] NVARCHAR (250)   NULL,
    CONSTRAINT [PK_TopicTypes_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 100)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Topic Types', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TopicTypes';

