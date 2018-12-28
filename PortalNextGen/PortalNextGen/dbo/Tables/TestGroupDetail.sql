CREATE TABLE [dbo].[TestGroupDetail] (
    [TestGroupDetailID]   INT           IDENTITY (1, 1) NOT NULL,
    [NodeID]              INT           NOT NULL,
    [TestCodeID]          INT           NULL,
    [univwsvcCodeID]      INT           NULL,
    [Rank]                INT           NOT NULL,
    [DisplayType]         CHAR (5)      NULL,
    [Name]                NVARCHAR (80) NOT NULL,
    [SourceCodeID]        INT           NULL,
    [AliasTestCodeID]     INT           NULL,
    [AliasUnivwsvcCodeID] INT           NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_TestGroupDetail_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TestGroupDetail_TestGroupDetailID] PRIMARY KEY CLUSTERED ([TestGroupDetailID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TestGroupDetail_NodeID_TestCodeID_univwsvcCodeID_Rank]
    ON [dbo].[TestGroupDetail]([NodeID] ASC, [TestCodeID] ASC, [univwsvcCodeID] ASC, [Rank] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TestGroupDetail_TestCodeID_univwsvcCodeID_NodeID_SourceCodeID]
    ON [dbo].[TestGroupDetail]([TestCodeID] ASC, [univwsvcCodeID] ASC, [NodeID] ASC, [SourceCodeID] ASC);

