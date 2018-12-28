CREATE TABLE [dbo].[ProductMap] (
    [ProductMapID]    INT           IDENTITY (1, 1) NOT NULL,
    [ProductID]       INT           NOT NULL,
    [FeatureID]       INT           NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_ProductMap_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ProductMap_ProductMapID] PRIMARY KEY CLUSTERED ([ProductMapID] ASC),
    CONSTRAINT [FK_ProductMap_Feature_FeatureID] FOREIGN KEY ([FeatureID]) REFERENCES [dbo].[Feature] ([FeatureID]),
    CONSTRAINT [FK_ProductMap_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductMap_ProductCode_FeatureCode]
    ON [dbo].[ProductMap]([ProductID] ASC, [FeatureID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_ProductMap_Product_ProductID]
    ON [dbo].[ProductMap]([ProductID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_ProductMap_Feature_FeatureID]
    ON [dbo].[ProductMap]([FeatureID] ASC);

