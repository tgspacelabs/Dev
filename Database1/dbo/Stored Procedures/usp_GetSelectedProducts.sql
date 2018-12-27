
CREATE PROCEDURE [dbo].[usp_GetSelectedProducts]
    (
     @product_cd VARCHAR(25)
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_organization].[organization_id],
        [category_cd],
        [parent_organization_id],
        [organization_cd],
        [organization_nm],
        [in_default_search],
        [monitor_disable_sw],
        [auto_collect_interval],
        [outbound_interval],
        [printer_name],
        [alarm_printer_name]
    FROM
        [dbo].[int_product_access],
        [dbo].[int_organization]
    WHERE
        [int_product_access].[organization_id] = [int_organization].[organization_id]
        AND [product_cd] = @product_cd
    ORDER BY
        [organization_nm];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetSelectedProducts';

