
CREATE PROCEDURE [dbo].[usp_DM3_AddMonitor]
  (
  @MonitorId		NVARCHAR(50),
  @Unit_Org_Id		NVARCHAR(50) = NULL,
  @Network_Id		NVARCHAR(50),
  @Node_Id			NVARCHAR(50),
  @Monitor_Type_cd	NVARCHAR(50) = NULL,
  @Monitor_Name		NVARCHAR(50),
  @Subnet			NVARCHAR(20) = NULL
  )
AS
BEGIN
insert into int_monitor (monitor_id, unit_org_id, network_id, node_id, bed_id, bed_cd, room, monitor_type_cd, monitor_name, subnet) 
		values (@MonitorId,@Unit_Org_Id,@Network_Id,@Node_Id,'0','0','0',@Monitor_Type_cd,@Monitor_Name,@Subnet)
	
END

