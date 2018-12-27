

/*Updates the patient Visit Information*/
CREATE PROCEDURE [dbo].[usp_HL7_UpdatePatientVisitInformation]
    (
     @EncounterId UNIQUEIDENTIFIER,
     @ModDt DATETIME = NULL,
     @AccountId UNIQUEIDENTIFIER = NULL,
     @StatusCd NVARCHAR(3),
     @PatientClassCid INT = NULL,
     @VipSw NCHAR(1) = NULL,
     @PatientTypeCid INT = NULL,
     @UnitOrgId UNIQUEIDENTIFIER,
     @AdmitDt DATETIME = NULL,
     @Rm NVARCHAR(80) = NULL,
     @Bed NVARCHAR(80) = NULL,
     @DischargeDt DATETIME = NULL,
     @MessageDateTime DATETIME = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [encounter_id],
        [organization_id],
        [mod_dt],
        [patient_id],
        [orig_patient_id],
        [account_id],
        [status_cd],
        [publicity_cid],
        [diet_type_cid],
        [patient_class_cid],
        [protection_type_cid],
        [vip_sw],
        [isolation_type_cid],
        [security_type_cid],
        [patient_type_cid],
        [admit_hcp_id],
        [med_svc_cid],
        [referring_hcp_id],
        [unit_org_id],
        [attend_hcp_id],
        [primary_care_hcp_id],
        [fall_risk_type_cid],
        [begin_dt],
        [ambul_status_cid],
        [admit_dt],
        [baby_cd],
        [rm],
        [recurring_cd],
        [bed],
        [discharge_dt],
        [newborn_sw],
        [discharge_dispo_cid],
        [monitor_created],
        [comment]
    FROM
        [dbo].[int_encounter];
    IF @ModDt IS NULL
        SET @ModDt = GETDATE();

    UPDATE
        [dbo].[int_encounter]
    SET
        [account_id] = @AccountId,
        [mod_dt] = @ModDt,
        [status_cd] = @StatusCd,
        [vip_sw] = @VipSw,
        [patient_type_cid] = @PatientTypeCid,
        [patient_class_cid] = @PatientClassCid,
        [unit_org_id] = @UnitOrgId,
        [admit_dt] = @AdmitDt,
        [rm] = @Rm,
        [bed] = @Bed,
        [begin_dt] = @MessageDateTime,
        [discharge_dt] = @DischargeDt
    WHERE
        [encounter_id] = @EncounterId;

    UPDATE
        [dbo].[int_encounter_map]
    SET
        [account_id] = @AccountId
    WHERE
        [encounter_id] = @EncounterId;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Update the patients Visit Information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_UpdatePatientVisitInformation';

