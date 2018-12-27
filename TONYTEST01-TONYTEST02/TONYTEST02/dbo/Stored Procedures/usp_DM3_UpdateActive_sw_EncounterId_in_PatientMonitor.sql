
CREATE PROCEDURE [dbo].[usp_DM3_UpdateActive_sw_EncounterId_in_PatientMonitor]
  (
	@MonitorID			NVARCHAR(50),
	@PatientGUID		NVARCHAR(50),
	@Connectdate		NVARCHAR(50) = NULL,
	@EncounterIDGUID	NVARCHAR(50) = NULL
	)
AS
 BEGIN
		update int_patient_monitor set active_sw = 1, encounter_id = @EncounterIDGUID where monitor_id = @MonitorID and patient_id = @PatientGUID and monitor_connect_dt = @Connectdate
	
 END

