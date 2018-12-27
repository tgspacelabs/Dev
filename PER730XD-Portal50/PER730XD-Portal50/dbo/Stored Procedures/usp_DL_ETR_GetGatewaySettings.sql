CREATE proc [dbo].[usp_DL_ETR_GetGatewaySettings]
(
@GatewayType NVARCHAR(10)
)
AS
BEGIN
if EXISTS(SELECT * FROM sys.all_objects WHERE name = 'int_DataLoader_ETR_Temp_Settings')
BEGIN
    SELECT *
            FROM 
            int_DataLoader_ETR_Temp_Settings 
            WHERE 
            gateway_type = @GatewayType
            ORDER BY 
            network
END
END

