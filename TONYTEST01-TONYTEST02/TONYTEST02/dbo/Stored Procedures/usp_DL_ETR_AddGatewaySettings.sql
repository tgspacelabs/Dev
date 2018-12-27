CREATE PROCEDURE [dbo].[usp_DL_ETR_AddGatewaySettings]
(
    @gateway_id UNIQUEIDENTIFIER,
    @gateway_type NVARCHAR(10),
    @farm_name NVARCHAR(5),
    @network NVARCHAR(30),
    @et_do_not_store_waveforms tinyint,
    @include_trans_chs NVARCHAR(256),
    @exclude_trans_chs NVARCHAR(256),
    @et_print_alarms tinyint
)
AS
  
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='int_DataLoader_ETR_Temp_Settings')
BEGIN 
CREATE TABLE [dbo].[int_DataLoader_ETR_Temp_Settings]
(
	[gateway_id] UNIQUEIDENTIFIER NOT NULL,
	[gateway_type] NVARCHAR(10) NULL,
	[farm_name] NVARCHAR(5) NULL,
    [network] NVARCHAR(30) NULL,
	[et_do_not_store_waveforms] TINYINT NULL,
	[include_trans_chs] NVARCHAR(255) NULL,
	[exclude_trans_chs] NVARCHAR(255) NULL,
	[et_print_alarms] TINYINT NULL
)
END

BEGIN
INSERT INTO int_DataLoader_ETR_Temp_Settings
(
    [gateway_id],
    [gateway_type],
    [farm_name],
    [network],
    [et_do_not_store_waveforms],
    [include_trans_chs],
    [exclude_trans_chs],   
    [et_print_alarms]
)
 
VALUES
( 
    @gateway_id,
    @gateway_type,
    @farm_name,
    @network,
    @et_do_not_store_waveforms, 
    @include_trans_chs,
    @exclude_trans_chs,
    @et_print_alarms
)
END


