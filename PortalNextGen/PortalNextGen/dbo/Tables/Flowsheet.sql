CREATE TABLE [dbo].[Flowsheet] (
    [FlowsheetID]     INT           IDENTITY (1, 1) NOT NULL,
    [FlowsheetType]   NVARCHAR (50) NOT NULL,
    [OwnerID]         INT           NULL,
    [Name]            NVARCHAR (50) NULL,
    [Description]     NVARCHAR (50) NULL,
    [DisplayInMenu]   TINYINT       CONSTRAINT [DF_Flowsheet_DisplayInMenu] DEFAULT ((1)) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Flowsheet_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Flowsheet_FlowsheetID] PRIMARY KEY CLUSTERED ([FlowsheetID] ASC)
);

