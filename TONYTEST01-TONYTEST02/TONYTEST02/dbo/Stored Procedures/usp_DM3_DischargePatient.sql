
CREATE PROCEDURE [dbo].[usp_DM3_DischargePatient]
  (
	@DischargeDate		NVARCHAR(50) = NULL,
	@EncounterIDGUID	NVARCHAR(50) = NULL,
	@MonitorID			NVARCHAR(50)
	)
AS
 BEGIN
 if (@DischargeDate = 'NULL')
	begin	
		set @DischargeDate = getdate() 
	end
 update int_encounter set discharge_dt = @DischargeDate,  status_cd = 'D' where encounter_id = @EncounterIDGUID
 update int_patient_monitor set active_sw = NULL where monitor_id = @MonitorID
 END

