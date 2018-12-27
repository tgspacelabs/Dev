

CREATE PROCEDURE [dbo].[p_ml_Load_Monitor_By_Id]
    (
     @monitorID UNIQUEIDENTIFIER
    )
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
        [monitor_type_cd],
        [organization_cd],
        [monitor_name],
        [outbound_interval],
        [subnet]
    FROM
        [dbo].[int_monitor]
        LEFT OUTER JOIN [dbo].[int_organization] ON ([unit_org_id] = [organization_id])
    WHERE
        ([monitor_id] = @monitorID);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_ml_Load_Monitor_By_Id';

