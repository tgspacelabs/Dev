﻿
CREATE VIEW [dbo].[v_LegacyMonitorCombined]
AS
SELECT Id as [monitor_id]
      ,UnitOrgId as [unit_org_id]
      ,NetworkId as [network_id]
      ,NodeId as [node_id]
      ,BedId as [bed_id]
      ,BedCd as [bed_cd]
      ,Room as [room]
      ,[Description] as [monitor_dsc]
      ,Name as [monitor_name]
      ,[Type] as [monitor_type_cd]
      ,Subnet as [subnet]
  FROM [v_LegacyMonitor]

UNION ALL

SELECT [monitor_id]
      ,[unit_org_id]
      ,[network_id]
      ,[node_id]
      ,[bed_id]
      ,[bed_cd]
      ,[room]
      ,[monitor_dsc]
      ,[monitor_name]
      ,[monitor_type_cd]
      ,[subnet]
  FROM [int_monitor]

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_LegacyMonitorCombined';

