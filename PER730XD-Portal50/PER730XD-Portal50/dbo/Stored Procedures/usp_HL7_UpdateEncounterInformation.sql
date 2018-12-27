
CREATE PROCEDURE [dbo].[usp_HL7_UpdateEncounterInformation]
(
    @EncounterId UNIQUEIDENTIFIER,
    @ModDt datetime=null,
    @AccountId UNIQUEIDENTIFIER,
    @StatusCd NVARCHAR(6),
    @PatientClassCid int,
    @VipSw nchar(2),
    @PatientTypeCid int,
    @MedSvcCid int,
    @UnitOrgId UNIQUEIDENTIFIER,
    @BeginDt datetime,
    @AmbulStatusCid int,
    @AdmitDt datetime,
    @Rm NVARCHAR(12),
    @Bed nchar(12),
    @DischargeDt datetime,
    @DischargeDispoCid int
)
AS 
BEGIN

IF @ModDt IS NULL SET @ModDt=GETDATE();

UPDATE int_encounter SET
    account_id=@AccountId,
    mod_dt=@ModDt,
    status_cd=@StatusCd,
    patient_class_cid=@PatientClassCid,
    vip_sw=@VipSw,
    patient_type_cid=@PatientTypeCid,
    med_svc_cid=@MedSvcCid,
    unit_org_id=@UnitOrgId,
    begin_dt=@BeginDt,
    ambul_status_cid=@AmbulStatusCid,
    admit_dt=@AdmitDt,
    rm=@Rm,
    bed=@Bed,
    discharge_dt=@DischargeDt,
    discharge_dispo_cid=@DischargeDispoCid
WHERE  encounter_id=@EncounterId;
END
