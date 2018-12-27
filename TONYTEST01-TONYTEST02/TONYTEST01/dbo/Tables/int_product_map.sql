CREATE TABLE [dbo].[int_product_map] (
    [product_cd] VARCHAR (25) NOT NULL,
    [feature_cd] VARCHAR (25) NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [pkey_ndx]
    ON [dbo].[int_product_map]([product_cd] ASC, [feature_cd] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'An associative table between the int_product table and the int_feature table. This table contains each feature within a given product. Each row is uniquely identified by the product_cd and feature_cd.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'int_product_map';

