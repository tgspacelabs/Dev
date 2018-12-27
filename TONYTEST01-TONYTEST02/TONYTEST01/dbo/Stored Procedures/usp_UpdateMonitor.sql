create proc [dbo].[usp_UpdateMonitor]
(
@monitor_dsc NVARCHAR(50),
@unit_Org_id UNIQUEIDENTIFIER,
@room  NVARCHAR(12),
@bed_cd  NVARCHAR(20),
@monitor_id UNIQUEIDENTIFIER
)
as
begin
	UPDATE 
                                                int_monitor 
                                                SET 
                                                monitor_dsc =@monitor_dsc,
                                                unit_Org_id =@unit_Org_id,
                                                room = @room, 
                                                bed_cd =@bed_cd
                                                WHERE 
                                                monitor_id=@monitor_id
	
   UPDATE [dbo].[Devices]
	  SET
		[Description] = @monitor_dsc,
		[Room] = @room
	  WHERE [Id] = @monitor_id
end
