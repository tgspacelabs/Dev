
CREATE PROCEDURE [dbo].[usp_GetProductSecurity]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [p].[product_cd],
        [p].[organization_id],
        [p].[license_no]
    FROM
        [dbo].[int_product_access] [p]
        INNER JOIN [dbo].[int_organization] [o] ON [p].[organization_id] = [o].[organization_id]
    WHERE
        [o].[category_cd] = 'D';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetProductSecurity';

