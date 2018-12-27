
CREATE PROCEDURE [dbo].[usp_GetFeaturelstForProducts]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [product_cd],
        [int_feature].[feature_cd],
        [descr] [feature_descr]
    FROM
        [dbo].[int_product_map],
        [dbo].[int_feature]
    WHERE
        [int_product_map].[feature_cd] = [int_feature].[feature_cd];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetFeaturelstForProducts';

