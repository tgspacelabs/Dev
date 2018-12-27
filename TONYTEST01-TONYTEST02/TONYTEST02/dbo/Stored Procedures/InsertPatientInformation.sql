
/* [InsertPatientInformation] is used to Insert the patient Information from any component
@PatientID is mandatory and the remaining are optional with default NULL values*/
CREATE PROCEDURE [dbo].[InsertPatientInformation]
(
	@PatientID UNIQUEIDENTIFIER,
	@NewPatientId	UNIQUEIDENTIFIER=null,
	@OrganDonorSw	nchar(4)=null,
	@LivingWillSw	nchar(4)=null,
	@BirthOrder		tinyint=null,
	@VeteranStatusCid	int=null,
	@BirthPlace		NVARCHAR(100)=null,
	@Ssn			NVARCHAR(30)=null,
	@MpiSsn1		int=null,
	@MpiSsn2		int=null,
	@MpiSsn3		int=null,
	@MpiSsn4		int=null,
	@DrivLicNo		NVARCHAR(50)=null,
	@MpiDl1			NVARCHAR(6)=null,
	@MpiDl2			NVARCHAR(6)=null,
	@MpiDl3			NVARCHAR(6)=null,
	@MpiDl4			NVARCHAR(6)=null,
	@DrivLicStateCode	NVARCHAR(6)=null,
	@dob			NVARCHAR(50)=null,
	@deathdt		NVARCHAR(50)=null,
	@NationalityCid	int=null,
	@CitizenshipCid	int=null,
	@EthnicGroupCid	int=null,
	@RaceCid		int=null,
	@GenderCid		int=null,
	@PrimaryLanguageCid	int=null,
	@MaritalStatusCid	int=null,
	@ReligionCid	int=null,
	@MonitorInterval	int=null,
	@Height			float=null,
	@Weight			float=null,
	@Bsa			float=null
)
AS
BEGIN
INSERT INTO int_patient
(
	patient_id
	,[new_patient_id]
	,[organ_donor_sw]
	,[living_will_sw]
	,[birth_order]
	,[veteran_status_cid]
	,[birth_place]
	,[ssn]
	,[mpi_ssn1]
	,[mpi_ssn2]
	,[mpi_ssn3]
	,[mpi_ssn4]
	,[driv_lic_no]
	,[mpi_dl1]
	,[mpi_dl2]
	,[mpi_dl3]
	,[mpi_dl4]
	,[driv_lic_state_code]
	,[dob]
	,[death_dt]
	,[nationality_cid]
	,[citizenship_cid]
	,[ethnic_group_cid]
	,[race_cid]
	,[gender_cid]
	,[primary_language_cid]
	,[marital_status_cid]
	,[religion_cid]
	,[monitor_interval]
	,[height]
	,[weight]
	,[bsa]
)
values
(
	@PatientID,
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
)
END

