
CREATE PROCEDURE [dbo].[p_cb_Load_Monitor_List]
AS
  BEGIN
    SELECT *
    FROM   int_monitor
           LEFT OUTER JOIN int_organization
             ON ( int_monitor.unit_org_id = int_organization.organization_id ) AND ( category_cd = 'D' )
    ORDER  BY monitor_id
  END


