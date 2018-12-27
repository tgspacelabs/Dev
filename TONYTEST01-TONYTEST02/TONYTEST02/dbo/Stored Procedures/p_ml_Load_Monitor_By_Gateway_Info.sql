
CREATE PROCEDURE [dbo].[p_ml_Load_Monitor_By_Gateway_Info]
  (
  @networkID VARCHAR(15),
  @nodeID    VARCHAR(15),
  @bedID     VARCHAR(3)
  )
AS
  BEGIN
    SELECT int_monitor.monitor_id,
           int_monitor.unit_org_id,
           int_monitor.network_id,
           int_monitor.node_id,
           int_monitor.bed_id,
           int_monitor.bed_cd,
           int_monitor.room,
           int_monitor.monitor_type_cd,
           int_organization.organization_cd,
           int_monitor.monitor_name,
           int_organization.outbound_interval,
           int_monitor.subnet
    FROM   int_monitor
           LEFT OUTER JOIN int_organization
             ON ( int_monitor.unit_org_id = int_organization.organization_id )
    WHERE  ( network_id = @networkID ) AND ( node_id = @nodeID ) AND ( bed_id = @bedID )
  END


