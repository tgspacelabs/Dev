 
CREATE PROCEDURE [dbo].[usp_DM3_GetMonitorEncounter]
    (
	@PatientGUID		NVARCHAR(50)=null,
	@ConnectionDate	NVARCHAR(50)=null
	)
	AS
	 BEGIN
	 select * from int_encounter 
		where patient_id = @PatientGUID and admit_dt = @ConnectionDate and monitor_created = 1 order by discharge_dt desc
	 END

