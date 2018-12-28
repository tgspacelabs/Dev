CREATE TABLE [dbo].[Product] (
    [ProductID]       INT           IDENTITY (1, 1) NOT NULL,
    [ProductCode]     VARCHAR (25)  NOT NULL,
    [Description]     VARCHAR (120) NULL,
    [HasAccess]       SMALLINT      NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Product_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_ProductCode]
    ON [dbo].[Product]([ProductCode] ASC);

