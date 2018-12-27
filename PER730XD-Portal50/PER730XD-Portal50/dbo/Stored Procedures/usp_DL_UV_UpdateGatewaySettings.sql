CREATE PROCEDURE [dbo].[usp_DL_UV_UpdateGatewaySettings]
(
    @gateway_type NVARCHAR(10),
    @network_name NVARCHAR(30),
    @network_id NVARCHAR(30),
    @node_name char(5),
    @node_id char(1024),
    @uv_organization_id UNIQUEIDENTIFIER,
    @uv_unit_id UNIQUEIDENTIFIER,
    @include_nodes NVARCHAR(255),
    @exclude_nodes NVARCHAR(255),
    @uv_do_not_store_waveforms tinyint,
    @print_requests tinyint,
    @make_time_master tinyint,
    @auto_assign_id tinyint,
    @new_mrn_format NVARCHAR(10),
    @uv_print_alarms tinyint,
    @debug_level int,
    @gateway_id UNIQUEIDENTIFIER
)
AS
  
BEGIN
UPDATE int_DataLoader_UV_Temp_Settings
SET

    gateway_type = @gateway_type,
    network_name = @network_name,
    network_id = @network_id, 
    node_name = @node_name,
    node_id = @node_id,
    uv_organization_id = @uv_organization_id,  
    uv_unit_id = @uv_unit_id,
    include_nodes = @include_nodes,  
    exclude_nodes = @exclude_nodes,     
    uv_do_not_store_waveforms = @uv_do_not_store_waveforms,        
    print_requests = @print_requests, 
    make_time_master = @make_time_master, 
    auto_assign_id = @auto_assign_id, 
    new_mrn_format = @new_mrn_format,           
    uv_print_alarms = @uv_print_alarms,
    debug_level = @debug_level  

WHERE gateway_id = @gateway_id
END

