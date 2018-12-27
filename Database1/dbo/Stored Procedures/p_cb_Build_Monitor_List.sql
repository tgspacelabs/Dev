

CREATE PROCEDURE [dbo].[p_cb_Build_Monitor_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [monitor_id],
        [unit_org_id],
        [network_id],
        [node_id],
        [bed_id],
        [bed_cd],
        [room],
        [monitor_dsc],
        [monitor_name],
        [monitor_type_cd],
        [subnet],
        [standby],
        [organization_cd],
        [outbound_interval]
    FROM
        [dbo].[int_monitor]
        LEFT OUTER JOIN [dbo].[int_organization] ON ([unit_org_id] = [organization_id])
    ORDER BY
        [monitor_name];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Build_Monitor_List';

