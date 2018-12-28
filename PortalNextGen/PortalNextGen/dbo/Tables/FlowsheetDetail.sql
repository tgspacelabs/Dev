CREATE TABLE [dbo].[FlowsheetDetail] (
    [FlowsheetDetailID] INT           IDENTITY (1, 1) NOT NULL,
    [FlowsheetID]       INT           NOT NULL,
    [Name]              NVARCHAR (80) NOT NULL,
    [DetailType]        NVARCHAR (50) NOT NULL,
    [ParentID]          INT           NOT NULL,
    [Sequence]          INT           NOT NULL,
    [TestCodeID]        INT           NOT NULL,
    [ShowOnlyWhenData]  TINYINT       NOT NULL,
    [IsCompressed]      TINYINT       NOT NULL,
    [IsVisible]         TINYINT       NOT NULL,
    [FlowsheetEntryID]  INT           NOT NULL,
    [CreatedDateTime]   DATETIME2 (7) CONSTRAINT [DF_FlowsheetDetail_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_FlowsheetDetail_FlowsheetDetailID] PRIMARY KEY CLUSTERED ([FlowsheetDetailID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_FlowsheetDetail_FlowsheetID_TestCodeID_FlowsheetDetailID]
    ON [dbo].[FlowsheetDetail]([FlowsheetID] ASC, [TestCodeID] ASC, [FlowsheetDetailID] ASC);

