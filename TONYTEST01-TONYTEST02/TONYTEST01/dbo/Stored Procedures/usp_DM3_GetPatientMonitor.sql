CREATE PROCEDURE [dbo].[usp_DM3_GetPatientMonitor]
  (
	@MonitorID			NVARCHAR(50),
	@PatientGUID		NVARCHAR(50),
	@Connectdate		NVARCHAR(50) = NULL
	)
AS
 BEGIN

	select * from int_patient_monitor where monitor_id = @MonitorID and patient_id = @PatientGUID and monitor_connect_dt = @Connectdate
 END
