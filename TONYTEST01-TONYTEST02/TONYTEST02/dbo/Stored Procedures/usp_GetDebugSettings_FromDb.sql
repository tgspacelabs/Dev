CREATE PROCEDURE [dbo].[usp_GetDebugSettings_FromDb]

as
begin
	select 
                                                        track_alarm_execution, 
                                                        track_vitals_update_execution
                                                        from
                                                        int_event_config
end

