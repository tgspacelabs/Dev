CREATE TABLE [dbo].[ReferenceRange] (
    [ReferenceRangeID] INT           NOT NULL,
    [ReferenceRange]   NVARCHAR (60) NOT NULL,
    [CreatedDateTime]  DATETIME2 (7) CONSTRAINT [DF_ReferenceRange_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ReferenceRange_ReferenceRangeID] PRIMARY KEY CLUSTERED ([ReferenceRangeID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ReferenceRange_ReferenceRangeID]
    ON [dbo].[ReferenceRange]([ReferenceRangeID] ASC);

