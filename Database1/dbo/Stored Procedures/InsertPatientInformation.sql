﻿

/* [InsertPatientInformation] is used to Insert the patient Information from any component
@PatientID is mandatory and the remaining are optional with default NULL values*/
CREATE PROCEDURE [dbo].[InsertPatientInformation]
    (
     @PatientID UNIQUEIDENTIFIER,
     @NewPatientId UNIQUEIDENTIFIER = NULL,
     @OrganDonorSw NCHAR(4) = NULL,
     @LivingWillSw NCHAR(4) = NULL,
     @BirthOrder TINYINT = NULL,
     @VeteranStatusCid INT = NULL,
     @BirthPlace NVARCHAR(100) = NULL,
     @Ssn NVARCHAR(30) = NULL,
     @MpiSsn1 INT = NULL,
     @MpiSsn2 INT = NULL,
     @MpiSsn3 INT = NULL,
     @MpiSsn4 INT = NULL,
     @DrivLicNo NVARCHAR(50) = NULL,
     @MpiDl1 NVARCHAR(6) = NULL,
     @MpiDl2 NVARCHAR(6) = NULL,
     @MpiDl3 NVARCHAR(6) = NULL,
     @MpiDl4 NVARCHAR(6) = NULL,
     @DrivLicStateCode NVARCHAR(6) = NULL,
     @dob NVARCHAR(50) = NULL,
     @deathdt NVARCHAR(50) = NULL,
     @NationalityCid INT = NULL,
     @CitizenshipCid INT = NULL,
     @EthnicGroupCid INT = NULL,
     @RaceCid INT = NULL,
     @GenderCid INT = NULL,
     @PrimaryLanguageCid INT = NULL,
     @MaritalStatusCid INT = NULL,
     @ReligionCid INT = NULL,
     @MonitorInterval INT = NULL,
     @Height FLOAT = NULL,
     @Weight FLOAT = NULL,
     @Bsa FLOAT = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_patient]
            ([patient_id],
             [new_patient_id],
             [organ_donor_sw],
             [living_will_sw],
             [birth_order],
             [veteran_status_cid],
             [birth_place],
             [ssn],
             [mpi_ssn1],
             [mpi_ssn2],
             [mpi_ssn3],
             [mpi_ssn4],
             [driv_lic_no],
             [mpi_dl1],
             [mpi_dl2],
             [mpi_dl3],
             [mpi_dl4],
             [driv_lic_state_code],
             [dob],
             [death_dt],
             [nationality_cid],
             [citizenship_cid],
             [ethnic_group_cid],
             [race_cid],
             [gender_cid],
             [primary_language_cid],
             [marital_status_cid],
             [religion_cid],
             [monitor_interval],
             [height],
             [weight],
             [bsa]
            )
    VALUES
            (@PatientID,
             @NewPatientId,
             @OrganDonorSw,
             @LivingWillSw,
             @BirthOrder,
             @VeteranStatusCid,
             @BirthPlace,
             @Ssn,
             @MpiSsn1,
             @MpiSsn2,
             @MpiSsn3,
             @MpiSsn4,
             @DrivLicNo,
             @MpiDl1,
             @MpiDl2,
             @MpiDl3,
             @MpiDl4,
             @DrivLicStateCode,
             @dob,
             @deathdt,
             @NationalityCid,
             @CitizenshipCid,
             @EthnicGroupCid,
             @RaceCid,
             @GenderCid,
             @PrimaryLanguageCid,
             @MaritalStatusCid,
             @ReligionCid,
             @MonitorInterval,
             @Height,
             @Weight,
             @Bsa
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Insert the patient Information from any component.  @PatientId is mandatory and the remaining are optional with default NULL values.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'InsertPatientInformation';

