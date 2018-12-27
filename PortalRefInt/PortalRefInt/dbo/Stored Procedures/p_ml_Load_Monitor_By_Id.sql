﻿CREATE PROCEDURE [dbo].[p_ml_Load_Monitor_By_Id]
    (
     @monitorID BIGINT
    )
AS
BEGIN
    SELECT
        [int_monitor].[monitor_id],
        [int_monitor].[unit_org_id],
        [int_monitor].[network_id],
        [int_monitor].[node_id],
        [int_monitor].[bed_id],
        [int_monitor].[bed_cd],
        [int_monitor].[room],
        [int_monitor].[monitor_type_cd],
        [int_organization].[organization_cd],
        [int_monitor].[monitor_name],
        [int_organization].[outbound_interval],
        [int_monitor].[subnet]
    FROM
        [dbo].[int_monitor]
        LEFT OUTER JOIN [dbo].[int_organization] ON [int_monitor].[unit_org_id] = [int_organization].[organization_id]
    WHERE
        [monitor_id] = @monitorID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_ml_Load_Monitor_By_Id';
