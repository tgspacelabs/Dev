
CREATE PROCEDURE [dbo].[usp_GetGatewayDetailsByCategoryAndMethod]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [imc].[code_id],
        [imc].[organization_id],
        [imc].[sys_id],
        [imc].[category_cd],
        [imc].[method_cd],
        [imc].[code],
        [imc].[verification_sw],
        [imc].[int_keystone_cd],
        [imc].[short_dsc],
        [imc].[spc_pcs_code]
    FROM
        [dbo].[int_misc_code] AS [imc]
    WHERE
        [imc].[category_cd] = 'USID'
        AND [imc].[method_cd] = N'GDS'
    ORDER BY
        [imc].[code];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetGatewayDetailsByCategoryAndMethod';

