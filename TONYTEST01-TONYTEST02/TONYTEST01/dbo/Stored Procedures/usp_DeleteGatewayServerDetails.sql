create proc [dbo].[usp_DeleteGatewayServerDetails]
(
@gatewayID UNIQUEIDENTIFIER
)
as
begin
delete 
	from 
	int_gateway_server 
	where
	gateway_id =@gatewayID
end
