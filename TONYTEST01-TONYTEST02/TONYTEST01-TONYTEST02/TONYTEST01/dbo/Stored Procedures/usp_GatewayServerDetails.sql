create proc [dbo].[usp_GatewayServerDetails]
(
@gatewayID UNIQUEIDENTIFIER,
@serverName NVARCHAR(50), 
@port int
)
as
begin
insert into int_gateway_server 
                    (
                    gateway_id,
                    server_name, 
                    port
                    ) 
                    values 
                    (
                    @gatewayID,
                    @serverName,
                    @port
                    )
end
