
/* This procedure Insert/ Update the patient information into respective tables.*/
CREATE PROCEDURE [dbo].[usp_HL7_SavePatientDemographicInformation]
(
@PatientTypeAccountNo bit,
@PatientMrn NVARCHAR(20),
@PatientAccount NVARCHAR(20)=null,
@OrganizationId UNIQUEIDENTIFIER,
@PatientGivenName NVARCHAR(48),
@PatientFamilyName NVARCHAR(48),
@PatientMiddleName NVARCHAR(48),
@PatientDob datetime,
@PatientGenderCodeId int,
@PatientId UNIQUEIDENTIFIER out,
@AccountId UNIQUEIDENTIFIER out
)
AS 
BEGIN
BEGIN TRY
    DECLARE @PatientMrnId UNIQUEIDENTIFIER,@PatientAccountId UNIQUEIDENTIFIER
	--get the patient mrn if exists in the database.
	SET @PatientMrnId=(SELECT patient_id FROM int_mrn_map where mrn_xid=@PatientMrn  AND organization_id = @OrganizationId AND merge_cd <> 'L');
	
	--if the patient identification is Account Number
	IF(@PatientTypeAccountNo=1)
	BEGIN
	--get the account number if exists in the database.
		SET @PatientAccountId=(SELECT patient_id FROM int_mrn_map WHERE mrn_xid=@PatientAccount AND organization_id=@OrganizationId AND merge_cd <> 'L');
	END
	
	--patient mrn exists in the database
	IF(@PatientMrnId IS NOT NULL)
		BEGIN
			--update the patient MRN
			Set @PatientId=@PatientMrnId
			exec usp_Hl7_UpdatePatientInfo @patientId=@PatientId,@mrn1=@PatientMrn,@mrn2=@PatientAccount,@FirstNm=@PatientGivenName,
			@MiddleNm=@PatientMiddleName,@LastNm=@PatientFamilyName,@dob=@PatientDob,@GenderCid=@PatientGenderCodeId
		END
	ELSE
	BEGIN
		--There is no existing int_mrn_map record based on mrn, and account number is primary id
		 IF(@PatientAccountId IS NOT NULL)
			 BEGIN
				Set @PatientId=@PatientAccountId;
				exec usp_Hl7_UpdatePatientInfo @patientId=@PatientId,@mrn1=@PatientMrn,@mrn2=@PatientAccount,@FirstNm=@PatientGivenName,
					@MiddleNm=@PatientMiddleName,@LastNm=@PatientFamilyName,@dob=@PatientDob,@GenderCid=@PatientGenderCodeId
			 END
		 ELSE
			 BEGIN
				--Inserts new patient information to respective tables here
				 Set @PatientId=NEWID();
				 exec usp_Hl7_SavePatientInformation @organizationId=@OrganizationId,@patientId=@PatientId,@mrn1=@PatientMrn,
				 @mrn2=@PatientAccount,@FirstNm=@PatientGivenName,@MiddleNm=@PatientMiddleName,@LastNm=@PatientFamilyName,@dob=@PatientDob,@GenderCid=@PatientGenderCodeId,@AccountId=@AccountId out;
			 END
	END
	
	IF(@PatientAccount IS NOT NULL)
	BEGIN
		SET @AccountId=(SELECT account_id FROM int_account WHERE account_xid = @PatientAccount AND organization_id = @OrganizationId)
		if(@AccountId IS NULL)
		BEGIN
			SET @AccountId=NEWID()
			exec [usp_InsertAccountInformation] @accountId=@AccountId,@orgId=@organizationId,@accountNumber=@PatientAccount
		END
	END
	
END TRY
BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;
		SELECT  @ErrorMessage = ERROR_MESSAGE(),
				@ErrorSeverity = ERROR_SEVERITY(),
				@ErrorState = ERROR_STATE();

		-- Use RAISERROR inside the CATCH block to return error
		-- information about the original error that caused
		-- execution to jump to the CATCH block.
		RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
END CATCH
END
