CREATE TABLE [dbo].[LoaderStatistic] (
    [LoaderStatisticID]     INT             IDENTITY (1, 1) NOT NULL,
    [StatisticDateTime]     DATETIME2 (7)   NOT NULL,
    [StatisticTransmission] NVARCHAR (1000) NULL,
    [CreatedDateTime]       DATETIME2 (7)   CONSTRAINT [DF_LoaderStatistic_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_LoaderStatistic_LoaderStatisticID] PRIMARY KEY CLUSTERED ([LoaderStatisticID] ASC)
);

