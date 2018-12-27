-- [AddPatientMonitor_Dm3] is used to Add or Update Encounter Table values in DM3 Loader
CREATE PROCEDURE [dbo].[usp_DM3_AddPatientMonitor]
  (
  @PatientMonitorGUID	NVARCHAR(50) = NULL,
  @PatientGUID			NVARCHAR(50) = NULL,
  @MonitorID			NVARCHAR(50) = NULL,
  @Connectdate			NVARCHAR(50) = NULL,
  @EncounterIDGUID		NVARCHAR(50) = NULL
  )
AS
BEGIN
insert into int_patient_monitor (
			patient_monitor_id, patient_id, 
			monitor_id, monitor_interval, 
			poll_type, monitor_connect_dt, 
			encounter_id, active_sw) 
	values (@PatientMonitorGUID,@PatientGUID,
			@MonitorID,1,'P',@Connectdate,@EncounterIDGUID, '1' )
End

