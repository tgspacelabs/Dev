CREATE TABLE [dbo].[SystemGenerationComment] (
    [SystemGenerationCommentID] INT           IDENTITY (1, 1) NOT NULL,
    [CommentDateTime]           DATETIME2 (7) NOT NULL,
    [Comment]                   VARCHAR (255) NOT NULL,
    [CreatedDateTime]           DATETIME2 (7) CONSTRAINT [DF_SystemGenerationComment_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SystemGenerationComment_SystemGenerationCommentID] PRIMARY KEY CLUSTERED ([SystemGenerationCommentID] ASC)
);

