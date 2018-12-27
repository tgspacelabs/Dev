create PROCEDURE [dbo].[usp_AddNewGatewaySettings]
  (
    @gateway_id UNIQUEIDENTIFIER,
    @gateway_type char(4),
    @network_id NVARCHAR(30), 
    @enable_sw tinyint,
    @recv_app NVARCHAR(30), 
    @send_app NVARCHAR(30),  
    @organization_id UNIQUEIDENTIFIER,
    @send_sys_id UNIQUEIDENTIFIER,
    @results_usid int,
    @sleep_secs int, 
    @debug_level int,
    @unit_org_id UNIQUEIDENTIFIER,
    @patient_id_type char(4),
    @auto_assign_id_sw tinyint, 
    @new_mrn_format NVARCHAR(80),
    @auto_chan_attach_sw tinyint,
    @live_vitals_sw tinyint,
    @live_waveform_size int,
    @decnet_node int,
    @node_name char(5),
    @nodes_excluded NVARCHAR(255),
    @nodes_included NVARCHAR(255),
    @timemaster_sw tinyint,
    @waveform_size int,
    @print_enabled_sw tinyint,
    @auto_record_alarm_sw tinyint,
    @collect_12_lead_sw tinyint,
    @print_auto_record_sw tinyint,
    @encryption_status bit
  )
AS
  BEGIN
    INSERT INTO int_gateway
    ([gateway_id]
    ,[gateway_type]
    ,[network_id]
    ,[hostname]
    ,[enable_sw]
    ,[recv_app]
    ,[send_app]
    ,[reconnect_secs]
    ,[organization_id]
    ,[send_sys_id]
    ,[results_usid]
    ,[sleep_secs]
    ,[add_monitors_sw]
    ,[add_patients_sw]
    ,[debug_level]
    ,[unit_org_id]
    ,[patient_id_type]
    ,[auto_assign_id_sw]
    ,[new_mrn_format]
    ,[auto_chan_attach_sw]
    ,[live_vitals_sw]
    ,[live_waveform_size]
    ,[decnet_node]
    ,[node_name]
    ,[nodes_excluded]
    ,[nodes_included]
    ,[timemaster_sw]
    ,[waveform_size]
    ,[print_enabled_sw]
    ,[auto_record_alarm_sw]
    ,[collect_12_lead_sw]
    ,[print_auto_record_sw]
    ,[encryption_status])
    
    VALUES
   ( 
    @gateway_id,
    @gateway_type,
    @network_id, 
    'localhost',
    @enable_sw,
    @recv_app, 
    @send_app,  
    0,
    @organization_id,
    @send_sys_id, 
    @results_usid, 
    @sleep_secs, 
    1, 
    1,
    @debug_level,
    @unit_org_id, 
    @patient_id_type,
    @auto_assign_id_sw, 
    @new_mrn_format, 
    @auto_chan_attach_sw,
    @live_vitals_sw,
    @live_waveform_size, 
    @decnet_node, 
    @node_name,
    @nodes_excluded, 
    @nodes_included, 
    @timemaster_sw,
    @waveform_size, 
    @print_enabled_sw, 
    @auto_record_alarm_sw, 
    @collect_12_lead_sw, 
    @print_auto_record_sw,
    @encryption_status)
  END
