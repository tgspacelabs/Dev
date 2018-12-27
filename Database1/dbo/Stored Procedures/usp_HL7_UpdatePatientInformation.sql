

CREATE PROCEDURE [dbo].[usp_HL7_UpdatePatientInformation]
    (
     @PatientID UNIQUEIDENTIFIER,
     @BirthOrder TINYINT,
     @VeteranStatusCid INT,
     @BirthPlace NVARCHAR(100),
     @Ssn NVARCHAR(30),
     @DrivLicNo NVARCHAR(50),
     @DrivLicStateCode NVARCHAR(6),
     @dob NVARCHAR(50),
     @deathdt NVARCHAR(50),
     @NationalityCid INT,
     @CitizenshipCid INT,
     @EthnicGroupCid INT,
     @RaceCid INT,
     @GenderCid INT,
     @PrimaryLanguageCid INT,
     @MaritalStatusCid INT,
     @ReligionCid INT,
     @LivingWillSw NCHAR(4) = NULL,
     @OrganDonorSw NCHAR(4) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_patient]
    SET
        [birth_order] = @BirthOrder,
        [veteran_status_cid] = @VeteranStatusCid,
        [birth_place] = @BirthPlace,
        [ssn] = @Ssn,
        [driv_lic_no] = @DrivLicNo,
        [driv_lic_state_code] = @DrivLicStateCode,
        [dob] = @dob,
        [death_dt] = @deathdt,
        [nationality_cid] = @NationalityCid,
        [citizenship_cid] = @CitizenshipCid,
        [ethnic_group_cid] = @EthnicGroupCid,
        [race_cid] = @RaceCid,
        [gender_cid] = @GenderCid,
        [primary_language_cid] = @PrimaryLanguageCid,
        [marital_status_cid] = @MaritalStatusCid,
        [religion_cid] = @ReligionCid,
        [organ_donor_sw] = ISNULL(@OrganDonorSw, [organ_donor_sw]),
        [living_will_sw] = ISNULL(@LivingWillSw, [living_will_sw])
    WHERE
        [patient_id] = @PatientID;

END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_UpdatePatientInformation';

