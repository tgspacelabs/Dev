CREATE PROCEDURE [dbo].[usp_DM3_UpdateLastPoleDate_ResultDate_in_patientmonitor]
 (
	@Last_Poll_Date		NVARCHAR(30)=null,
	@PatientGUID		NVARCHAR(50),
	@PatientMonitorGUID NVARCHAR(50)
	)
AS
 BEGIN
	update int_patient_monitor 
	set last_poll_dt = @Last_Poll_Date,   last_result_dt =@Last_Poll_Date 
	where patient_id =  @PatientGUID 
	and patient_monitor_id = @PatientMonitorGUID
 END

