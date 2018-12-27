create proc [dbo].[usp_GetCEISettings]

as
begin
    select 
        track_alarm_execution, 
        track_vitals_update_execution,
        alarm_notification_mode, 
        vitals_update_interval, 
        port_number
        
        from
        int_event_config
end
