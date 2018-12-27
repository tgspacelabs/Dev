create proc [dbo].[usp_CEI_GetSettings]
as
	begin
		Select 
		alarm_notification_mode, 
		vitals_update_interval, 
		alarm_polling_interval, 
		port_number, track_alarm_execution, 
		track_vitals_update_execution 
		from int_event_config
	end
