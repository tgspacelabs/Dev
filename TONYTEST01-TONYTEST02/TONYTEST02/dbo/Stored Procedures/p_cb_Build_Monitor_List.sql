
CREATE PROCEDURE [dbo].[p_cb_Build_Monitor_List]
AS
  BEGIN
    SELECT int_monitor.*,
           int_organization.organization_cd,
           outbound_interval
    FROM   int_monitor
           LEFT OUTER JOIN int_organization
             ON ( int_monitor.unit_org_id = int_organization.organization_id )
    ORDER  BY monitor_name
  END


