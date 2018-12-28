CREATE TABLE [dbo].[NavigationButton] (
    [NavigationButtonID] INT           IDENTITY (1, 1) NOT NULL,
    [Description]        NVARCHAR (80) NOT NULL,
    [ImageIndex]         INT           NULL,
    [Position]           INT           NOT NULL,
    [FormName]           VARCHAR (255) NOT NULL,
    [NodeID]             INT           NULL,
    [Shortcut]           NCHAR (1)     NULL,
    [CreatedDateTime]    DATETIME2 (7) CONSTRAINT [DF_NavigationButton_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_NavigationButton_NavigationButtonID] PRIMARY KEY CLUSTERED ([NavigationButtonID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_NavigationButton_Description_Position_FormName_NodeID]
    ON [dbo].[NavigationButton]([Description] ASC, [Position] ASC, [FormName] ASC, [NodeID] ASC);

