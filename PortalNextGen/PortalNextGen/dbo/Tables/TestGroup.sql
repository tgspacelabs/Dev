CREATE TABLE [dbo].[TestGroup] (
    [TestGroupID]     INT           IDENTITY (1, 1) NOT NULL,
    [NodeID]          INT           NOT NULL,
    [Rank]            INT           NOT NULL,
    [DisplayInAll]    TINYINT       NOT NULL,
    [ParentNodeID]    INT           NOT NULL,
    [DisplayType]     CHAR (5)      NOT NULL,
    [NodeName]        NVARCHAR (80) NOT NULL,
    [ParameterString] NVARCHAR (80) NOT NULL,
    [DisplayInMenu]   TINYINT       NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_TestGroup_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TestGroup_TestGroupID] PRIMARY KEY CLUSTERED ([TestGroupID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TestGroup_NodeID]
    ON [dbo].[TestGroup]([NodeID] ASC);

