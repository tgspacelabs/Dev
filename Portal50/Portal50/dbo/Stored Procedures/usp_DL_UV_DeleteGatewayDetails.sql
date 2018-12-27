CREATE PROC [dbo].[usp_DL_UV_DeleteGatewayDetails]
(
@gatewayID UNIQUEIDENTIFIER
)
AS
BEGIN
	DELETE FROM
	int_DataLoader_UV_Temp_Settings 
	WHERE 
	gateway_id =@gatewayID 
END

