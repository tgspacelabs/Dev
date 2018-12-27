CREATE PROCEDURE [dbo].[usp_DeleteGatewayDetails]
(
@gatewayID UNIQUEIDENTIFIER
)
as
begin
	delete 
	from
	int_gateway 
	where 
	gateway_id =@gatewayID 
end

