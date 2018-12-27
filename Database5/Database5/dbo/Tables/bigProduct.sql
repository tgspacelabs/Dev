﻿CREATE TABLE [dbo].[bigProduct] (
    [ProductID]             INT            NOT NULL,
    [Name]                  NVARCHAR (80)  NULL,
    [ProductNumber]         NVARCHAR (56)  NULL,
    [MakeFlag]              [dbo].[Flag]   NOT NULL,
    [FinishedGoodsFlag]     [dbo].[Flag]   NOT NULL,
    [Color]                 NVARCHAR (15)  NULL,
    [SafetyStockLevel]      SMALLINT       NOT NULL,
    [ReorderPoint]          SMALLINT       NOT NULL,
    [StandardCost]          MONEY          NOT NULL,
    [ListPrice]             MONEY          NOT NULL,
    [Size]                  NVARCHAR (5)   NULL,
    [SizeUnitMeasureCode]   NCHAR (3)      NULL,
    [WeightUnitMeasureCode] NCHAR (3)      NULL,
    [Weight]                DECIMAL (8, 2) NULL,
    [DaysToManufacture]     INT            NOT NULL,
    [ProductLine]           NCHAR (2)      NULL,
    [Class]                 NCHAR (2)      NULL,
    [Style]                 NCHAR (2)      NULL,
    [ProductSubcategoryID]  INT            NULL,
    [ProductModelID]        INT            NULL,
    [SellStartDate]         DATETIME       NOT NULL,
    [SellEndDate]           DATETIME       NULL,
    [DiscontinuedDate]      DATETIME       NULL,
    CONSTRAINT [pk_bigProduct] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);

