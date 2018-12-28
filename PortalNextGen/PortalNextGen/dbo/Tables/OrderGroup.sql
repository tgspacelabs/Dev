CREATE TABLE [dbo].[OrderGroup] (
    [OrderGroupID]    INT           IDENTITY (1, 1) NOT NULL,
    [NodeID]          INT           NOT NULL,
    [Rank]            INT           NOT NULL,
    [ParentNodeID]    INT           NULL,
    [NodeName]        NVARCHAR (80) NOT NULL,
    [DisplayInMenu]   TINYINT       NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_OrderGroup_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_OrderGroup_OrderGroupID] PRIMARY KEY CLUSTERED ([OrderGroupID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_OrderGroup_NodeID_ParentNodeID_NodeName]
    ON [dbo].[OrderGroup]([NodeID] ASC, [ParentNodeID] ASC, [NodeName] ASC);

