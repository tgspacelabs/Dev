
--DM3 Procedures

-- [UpdateDateInEncounter] is used to Update MonitorId and EncounterId in DM3 Loader
CREATE PROCEDURE [dbo].[usp_DM3_UpdateDateInEncounter]
  (
  @MonitorId		NVARCHAR(50)=NULL,
  @EncounterId		NVARCHAR(50)=NULL
  )
AS

Begin
	update int_encounter 
	set discharge_dt = GETDATE(),
	status_cd = 'D' 
	where status_cd = 'C' 
		and encounter_id 
		in (select encounter_id 
			from int_patient_monitor 
			where monitor_id = @MonitorId 
			and encounter_id <> @EncounterId
			);
End

