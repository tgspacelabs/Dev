
/*Updates the patient Visit Information*/
CREATE PROCEDURE [dbo].[usp_HL7_UpdatePatientVisitInformation]
(
	@EncounterId UNIQUEIDENTIFIER,
	@ModDt datetime=null,
	@AccountId UNIQUEIDENTIFIER=null,
	@StatusCd NVARCHAR(3),
	@PatientClassCid int=null,
	@VipSw nchar(1)=null,
	@PatientTypeCid int=null,
	@UnitOrgId UNIQUEIDENTIFIER,
	@AdmitDt datetime=null,
	@Rm NVARCHAR(80)=null,
	@Bed NVARCHAR(80)=null,
	@DischargeDt datetime=null,
	@MessageDateTime datetime=null
)
AS 
BEGIN
select * from int_encounter
IF @ModDt IS NULL SET @ModDt=GETDATE();

UPDATE int_encounter SET
	account_id=@AccountId,
	mod_dt=@ModDt,
	status_cd=@StatusCd,
	vip_sw=@VipSw,
	patient_type_cid=@PatientTypeCid,
	patient_class_cid=@PatientClassCid,
	unit_org_id=@UnitOrgId,
	admit_dt=@AdmitDt,
	rm=@Rm,
	bed=@Bed,
	begin_dt=@MessageDateTime,
	discharge_dt=@DischargeDt

WHERE  encounter_id=@EncounterId;

UPDATE int_encounter_map SET
	account_id=@AccountId
WHERE  encounter_id=@EncounterId;
END
