create proc [dbo].[usp_UpdateCEISettings]
(
@alarmNotificationMode int=null,
@vitalsUpdateInterval int=null,
@portNumber int=null,
@trackAlarmExecution tinyint=null,
@trackVitalsUpdateExecution tinyint=null
)
as
begin
UPDATE int_event_config
   SET	alarm_notification_mode = ISNULL(@alarmNotificationMode,alarm_notification_mode),
		vitals_update_interval = ISNULL(@vitalsUpdateInterval,vitals_update_interval),
		  port_number = ISNULL(@portNumber,port_number),
		  track_alarm_execution = ISNULL(@trackAlarmExecution,track_alarm_execution),
		  track_vitals_update_execution = ISNULL(@trackVitalsUpdateExecution,track_vitals_update_execution)

end
