CREATE TABLE [dbo].[DocumentGroup] (
    [DocumentGroupID] INT           IDENTITY (1, 1) NOT NULL,
    [NodeID]          INT           NULL,
    [Rank]            INT           NULL,
    [ParentNodeID]    INT           NULL,
    [NodeName]        NVARCHAR (80) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_DocumentGroup_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_DocumentGroup_DocumentGroupID] PRIMARY KEY CLUSTERED ([DocumentGroupID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DocumentGroup_NodeID_Rank]
    ON [dbo].[DocumentGroup]([NodeID] ASC, [Rank] ASC);

