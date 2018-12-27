

/*[usp_InsertEncounterInformation] used to insert Encounter information*/
CREATE PROCEDURE [dbo].[usp_InsertEncounterInformation]
(
    @EncounterId UNIQUEIDENTIFIER,
    @OrgId UNIQUEIDENTIFIER=null,
    @ModDt datetime=null,
    @PatientId UNIQUEIDENTIFIER=null,
    @OrgPatientId UNIQUEIDENTIFIER=null,
    @AccountId UNIQUEIDENTIFIER=null,
    @StatusCd NVARCHAR(6)=null,
    @PublicityCid int=null,
    @DietTypeCid int=null,
    @PatientClassCid int=null,
    @protectionTypeCid int=null,
    @VipSw nchar(2)=null,
    @IsolationTypeCid int=null,
    @SecurityTypeCid int=null,
    @PatientTypeCid int=null,
    @AdmitHcpId UNIQUEIDENTIFIER=null,
    @MedSvcCid int=null,
    @ReferringHcpId UNIQUEIDENTIFIER=null,
    @UnitOrgId UNIQUEIDENTIFIER=null,
    @AttendHcpId UNIQUEIDENTIFIER=null,
    @PrimaryCareHcpId UNIQUEIDENTIFIER=null,
    @FallRiskTypeCid int=null,
    @BeginDt datetime=null,
    @AmbulStatusCid int=null,
    @AdmitDt datetime=null,
    @BabyCd nchar(2)=null,
    @Rm NVARCHAR(12)=null,
    @RecurringCd  nchar(2)=null,
    @Bed nchar(12)=null,
    @Discharge_dt datetime=null,
    @NewbornSw nchar(2)=null,
    @DischargeDispoCid int=null,
    @MonitorCreated tinyint=null,
    @comment NVARCHAR(200)=null
)
AS 
BEGIN
    INSERT INTO [dbo].[int_encounter]
    ([encounter_id]
    ,[organization_id]
    ,[mod_dt]
    ,[patient_id]
    ,[orig_patient_id]
    ,[account_id]
    ,[status_cd]
    ,[publicity_cid]
    ,[diet_type_cid]
    ,[patient_class_cid]
    ,[protection_type_cid]
    ,[vip_sw]
    ,[isolation_type_cid]
    ,[security_type_cid]
    ,[patient_type_cid]
    ,[admit_hcp_id]
    ,[med_svc_cid]
    ,[referring_hcp_id]
    ,[unit_org_id]
    ,[attend_hcp_id]
    ,[primary_care_hcp_id]
    ,[fall_risk_type_cid]
    ,[begin_dt]
    ,[ambul_status_cid]
    ,[admit_dt]
    ,[baby_cd]
    ,[rm]
    ,[recurring_cd]
    ,[bed]
    ,[discharge_dt]
    ,[newborn_sw]
    ,[discharge_dispo_cid]
    ,[monitor_created]
    ,[comment])
    VALUES
    (
    @EncounterId,
    @OrgId,
    GETDATE(),
    @PatientId,
    @OrgPatientId,
    @AccountId,
    @StatusCd,
    @PublicityCid,
    @DietTypeCid,
    @PatientClassCid,
    @protectionTypeCid,
    @VipSw,
    @IsolationTypeCid,
    @SecurityTypeCid,
    @PatientTypeCid,
    @AdmitHcpId,
    @MedSvcCid,
    @ReferringHcpId,
    @UnitOrgId,
    @AttendHcpId ,
    @PrimaryCareHcpId ,
    @FallRiskTypeCid,
    @BeginDt,
    @AmbulStatusCid,
    @AdmitDt,
    @BabyCd,
    @Rm,
    @RecurringCd,
    @Bed,
    @Discharge_dt,
    @NewbornSw,
    @DischargeDispoCid,
    @MonitorCreated,
    @comment
    )
END
