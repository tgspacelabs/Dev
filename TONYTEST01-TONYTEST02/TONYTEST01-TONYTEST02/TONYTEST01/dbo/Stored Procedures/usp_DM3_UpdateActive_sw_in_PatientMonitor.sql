CREATE PROCEDURE [dbo].[usp_DM3_UpdateActive_sw_in_PatientMonitor]
  (
	@MonitorID			NVARCHAR(50)
  )
AS
 BEGIN

	update int_patient_monitor set active_sw = NULL where monitor_id = @MonitorID
		
 END
