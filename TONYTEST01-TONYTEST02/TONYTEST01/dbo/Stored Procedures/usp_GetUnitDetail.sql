

create proc [dbo].[usp_GetUnitDetail]
(
@organization_id UNIQUEIDENTIFIER
)
as
begin
	SELECT 
                                                auto_collect_interval,
                                                printer_name,
                                                Alarm_printer_name,
											    outbound_interval
                                                FROM 
                                                int_organization
                                                WHERE
                                                organization_id =@organization_id
end

