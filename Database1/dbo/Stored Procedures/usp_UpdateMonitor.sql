
CREATE PROCEDURE [dbo].[usp_UpdateMonitor]
    (
     @monitor_dsc NVARCHAR(50),
     @unit_Org_id UNIQUEIDENTIFIER,
     @room NVARCHAR(12),
     @bed_cd NVARCHAR(20),
     @monitor_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_monitor]
    SET
        [monitor_dsc] = @monitor_dsc,
        [unit_org_id] = @unit_Org_id,
        [room] = @room,
        [bed_cd] = @bed_cd
    WHERE
        [monitor_id] = @monitor_id;
	
    UPDATE
        [dbo].[Devices]
    SET
        [Description] = @monitor_dsc,
        [Room] = @room
    WHERE
        [Id] = @monitor_id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_UpdateMonitor';

