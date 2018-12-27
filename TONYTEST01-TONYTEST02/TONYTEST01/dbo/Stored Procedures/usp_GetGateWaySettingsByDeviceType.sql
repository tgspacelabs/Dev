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
            order by 
            network_id
end
