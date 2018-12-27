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
    SELECT
        [int_encounter].[encounter_id],
        [int_encounter].[organization_id],
        [int_encounter].[mod_dt],
        [int_encounter].[patient_id],
        [int_encounter].[orig_patient_id],
        [int_encounter].[account_id],
        [int_encounter].[status_cd],
        [int_encounter].[publicity_cid],
        [int_encounter].[diet_type_cid],
        [int_encounter].[patient_class_cid],
        [int_encounter].[protection_type_cid],
        [int_encounter].[vip_sw],
        [int_encounter].[isolation_type_cid],
        [int_encounter].[security_type_cid],
        [int_encounter].[patient_type_cid],
        [int_encounter].[admit_hcp_id],
        [int_encounter].[med_svc_cid],
        [int_encounter].[referring_hcp_id],
        [int_encounter].[unit_org_id],
        [int_encounter].[attend_hcp_id],
        [int_encounter].[primary_care_hcp_id],
        [int_encounter].[fall_risk_type_cid],
        [int_encounter].[begin_dt],
        [int_encounter].[ambul_status_cid],
        [int_encounter].[admit_dt],
        [int_encounter].[baby_cd],
        [int_encounter].[rm],
        [int_encounter].[recurring_cd],
        [int_encounter].[bed],
        [int_encounter].[discharge_dt],
        [int_encounter].[newborn_sw],
        [int_encounter].[discharge_dispo_cid],
        [int_encounter].[monitor_created],
        [int_encounter].[comment]
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

