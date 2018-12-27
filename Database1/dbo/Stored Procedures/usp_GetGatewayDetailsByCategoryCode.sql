
CREATE PROCEDURE [dbo].[usp_GetGatewayDetailsByCategoryCode]
    (
     @categoryCode CHAR(1) = NULL,
     @parentOrganizationId UNIQUEIDENTIFIER = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF (@parentOrganizationId IS NULL)
    BEGIN
        SELECT
            [io].[organization_id],
            [io].[category_cd],
            [io].[parent_organization_id],
            [io].[organization_cd],
            [io].[organization_nm],
            [io].[in_default_search],
            [io].[monitor_disable_sw],
            [io].[auto_collect_interval],
            [io].[outbound_interval],
            [io].[printer_name],
            [io].[alarm_printer_name]
        FROM
            [dbo].[int_organization] AS [io]
        WHERE
            [io].[category_cd] = @categoryCode
        ORDER BY
            [io].[category_cd]; 
    END;
    ELSE
    BEGIN        
        SELECT
            [io].[organization_id],
            [io].[category_cd],
            [io].[parent_organization_id],
            [io].[organization_cd],
            [io].[organization_nm],
            [io].[in_default_search],
            [io].[monitor_disable_sw],
            [io].[auto_collect_interval],
            [io].[outbound_interval],
            [io].[printer_name],
            [io].[alarm_printer_name]
        FROM
            [dbo].[int_organization] AS [io]
        WHERE
            [io].[category_cd] = @categoryCode
            AND [io].[parent_organization_id] = @parentOrganizationId
        ORDER BY
            [io].[category_cd]; 
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetGatewayDetailsByCategoryCode';

