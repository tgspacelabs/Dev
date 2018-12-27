
CREATE PROCEDURE [dbo].[p_cb_Load_Monitor]
  (
  @MonitorId UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT *
    FROM   int_monitor
           LEFT OUTER JOIN int_organization
             ON ( int_monitor.unit_org_id = int_organization.organization_id )
    WHERE  ( int_monitor.monitor_id = @MonitorId )
  END


