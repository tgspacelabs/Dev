CREATE PROCEDURE [dbo].[usp_DL_ETR_UpdateGatewaySettings]
(
    @gateway_type NVARCHAR(10),
    @farm_name NVARCHAR(5),
    @network NVARCHAR(30),
    @et_do_not_store_waveforms tinyint,
    @include_trans_chs NVARCHAR(256),
    @exclude_trans_chs NVARCHAR(256),
    @et_print_alarms tinyint,
    @gateway_id UNIQUEIDENTIFIER
)
AS
  
BEGIN
UPDATE int_DataLoader_ETR_Temp_Settings
SET

    gateway_type = @gateway_type,
    farm_name = @farm_name,  
    network = @network,
    et_do_not_store_waveforms = @et_do_not_store_waveforms,      
    include_trans_chs = @include_trans_chs,
    exclude_trans_chs = @exclude_trans_chs,     
    et_print_alarms = @et_print_alarms   

WHERE gateway_id = @gateway_id
END

