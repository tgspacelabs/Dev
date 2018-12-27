CREATE PROCEDURE [dbo].[usp_DL_UV_GetGatewaySettings]
(
@GatewayType NVARCHAR(10)
)
AS
BEGIN
if EXISTS(SELECT * FROM sys.all_objects WHERE name = 'int_DataLoader_UV_Temp_Settings')
BEGIN
	SELECT *
            FROM 
            int_DataLoader_UV_Temp_Settings 
            WHERE 
            gateway_type = @GatewayType
            ORDER BY 
            network_name
END
END


