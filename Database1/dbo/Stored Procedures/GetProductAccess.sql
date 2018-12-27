

CREATE PROCEDURE [dbo].[GetProductAccess]
    (
     @ProductCd AS VARCHAR(25),
     @UnitId AS UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [P].[has_access]
    FROM
        [dbo].[int_product] [P]
        INNER JOIN [dbo].[int_product_access] [PA] ON [P].[product_cd] = [PA].[product_cd]
        INNER JOIN [dbo].[int_organization] [O] ON [PA].[organization_id] = [O].[organization_id]
    WHERE
        [PA].[product_cd] = @ProductCd
        AND [O].[category_cd] = 'D'
        AND [O].[organization_id] = @UnitId;

END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetProductAccess';

