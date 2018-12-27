create proc [dbo].[usp_GetGateWaySettingsByDeviceType]
(
@GatewayType NVARCHAR(10)
)
as
begin
    select *
            from 
            int_gateway 
            where 
            gateway_type = @GatewayType
            ORDER BY 
            network_id
end
