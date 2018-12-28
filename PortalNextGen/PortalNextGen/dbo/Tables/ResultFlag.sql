CREATE TABLE [dbo].[ResultFlag] (
    [ResultFlagID]     INT           IDENTITY (1, 1) NOT NULL,
    [FlagID]           INT           NOT NULL,
    [Flag]             NVARCHAR (10) NOT NULL,
    [DisplayFront]     NVARCHAR (10) NULL,
    [DisplayBack]      NVARCHAR (10) NULL,
    [BitmapIndexFront] INT           NULL,
    [BitmapIndexBack]  INT           NULL,
    [ColorForeground]  VARCHAR (20)  NULL,
    [ColorBackground]  VARCHAR (20)  NULL,
    [SystemID]         INT           NULL,
    [Comment]          NVARCHAR (30) NULL,
    [LegendRank]       INT           NOT NULL,
    [SeverityRank]     INT           NULL,
    [CreatedDateTime]  DATETIME2 (7) CONSTRAINT [DF_ResultFlag_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ResultFlag_ResultFlagID] PRIMARY KEY CLUSTERED ([ResultFlagID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ResultFlag_Flag_SystemID]
    ON [dbo].[ResultFlag]([Flag] ASC, [SystemID] ASC);

