CREATE PROC [dbo].[usp_DL_ETR_DeleteGatewayDetails]
(
@gatewayID UNIQUEIDENTIFIER
)
AS
BEGIN
    DELETE FROM
    int_DataLoader_ETR_Temp_Settings 
    WHERE 
    gateway_id =@gatewayID 
END

--====================================================================================================================

