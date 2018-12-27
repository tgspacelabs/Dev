create proc [dbo].[usp_UpdateOrgRecord]
(
@auto_collect_interval int,
@outbound_interval int,
@printer_name varchar(255), 
@alarm_printer_name varchar(255), 
@organization_id UNIQUEIDENTIFIER
)
as
begin
	UPDATE 
                                                int_organization 
                                                SET  
                                                auto_collect_interval = @auto_collect_interval,
                                                outbound_interval =@outbound_interval,
                                                printer_name = @printer_name, 
											    alarm_printer_name = @alarm_printer_name
                                                WHERE 
                                                organization_id=@organization_id
end

