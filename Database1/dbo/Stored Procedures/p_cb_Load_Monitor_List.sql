

CREATE PROCEDURE [dbo].[p_cb_Load_Monitor_List]
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
        [organization_id],
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
        [dbo].[int_monitor]
        LEFT OUTER JOIN [dbo].[int_organization] ON ([unit_org_id] = [organization_id])
                                            AND ([category_cd] = 'D')
    ORDER BY
        [monitor_id];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Load_Monitor_List';

