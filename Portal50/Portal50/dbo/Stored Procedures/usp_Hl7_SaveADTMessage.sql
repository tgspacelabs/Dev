
/* Saves ADT A01 message*/
 CREATE PROCEDURE [dbo].[usp_Hl7_SaveADTMessage] 
 (
	@MessageNumber int,
	/*Configuration settings*/
	@DynAddOrgs bit,
	@DynAddSendingSys bit,
	@PatientTypeAccountNo bit,
	@UniqueVisitNumber bit,
	@DynamicallyAddNursingUnits bit,
	@DynamicallyAddUSID bit,
	/*Configuration settings*/

	/*Msh(organization Information)*/
	@SendingSystem NVARCHAR(180),
	@SendingFacility NVARCHAR(180),
	/*Msh(organization Information)*/
	
	/*Patient Demographic information*/
	@PatientMrn NVARCHAR(20),
	@PatientAccount NVARCHAR(20)=null,
	@PatientGivenName NVARCHAR(48)=null,
	@PatientFamilyName NVARCHAR(48)=null,
	@PatientMiddleName NVARCHAR(48)=null,
	@PatientDob datetime=null,
	@PatientSex NVARCHAR(1)=null,
	/*Patient Demographic information*/

	/*Patient Visit Information*/
	@PatientClass NVARCHAR(1),
	@PatientPointOfCare NVARCHAR(80),
	@PatientVisitNumber NVARCHAR(20),
	@PatientRoom NVARCHAR(80)=null,
	@PatientBed NVARCHAR(80)=null,
	@VIPIndicator nchar(2)=null,
	@AdmitDateTime datetime=null,
	@DischargeDateTime datetime=null
	/*Patient Visit Information*/
 )
 AS
 BEGIN

BEGIN TRY
--Getting the Message Control Id from the message No
	DECLARE @MessageControlId NVARCHAR(10)
	SET @MessageControlId=(SELECT MessageControlId FROM Hl7InboundMessage WHERE MessageNo=@MessageNumber);
--Getting the Message Control Id from the message No

--Checking the facility and sending system existing in the current system, if not returing the error message.
	DECLARE @FacilityId UNIQUEIDENTIFIER,@SendingSysId UNIQUEIDENTIFIER
		EXEC usp_Hl7_InsertInboundFacility @SendingFacility,@DynAddOrgs,@FacilityId out;
	IF(@FacilityId IS NOT NULL)
	BEGIN 
		EXEC usp_Hl7_InsertInboundSendingSystem @SendingSystem,@DynAddSendingSys,@FacilityId,@SendingSysId out;
	END
	IF(@FacilityId IS NULL OR @SendingSysId IS NULL)
	BEGIN
		INSERT INTO Hl7PatientLink(MessageNo,PatientMrn,PatientVisitNumber,PatientId)Values(@MessageNumber,@PatientMrn,@PatientVisitNumber,null);
		RAISERROR (N'Sending Application "%s" or Sending Facility "%s" is not present at the database for MessageControlId="%s".',16,1,@SendingSystem,@SendingFacility,@MessageControlId);
		return;
	END
--Checking the facility and sending system existing in the current system, if not returing the error message.

---Inserts the new unit if Dynamically Add nursing units are set to true--
	Declare @UnitId UNIQUEIDENTIFIER
	set @UnitId=(SELECT organization_id FROM int_organization WHERE category_cd = 'D' AND organization_cd = @PatientPointOfCare AND parent_organization_id = @FacilityId);
	if(@UnitId IS NULL)
	BEGIN
		IF(@DynamicallyAddNursingUnits=1)
		BEGIN
			SET @UnitId=NEWID();
			exec usp_InsertOrganizationInformation @organizationId=@UnitId,@categoryCd='D',@autocollectInterval=1,@parentOrganizationId=@FacilityId,@organizationCd=@PatientPointOfCare,@organizationNm=@PatientPointOfCare;
		END
		ELSE
		BEGIN
			INSERT INTO Hl7PatientLink(MessageNo,PatientMrn,PatientVisitNumber,PatientId)Values(@MessageNumber,@PatientMrn,@PatientVisitNumber,null);
			RAISERROR ('Facility for "%s" unit is not present at the database or DynAddNursingUnits configuration is set to false for MessageControlId="%s".',16,1,@PatientPointOfCare,@MessageControlId);
			return;
		END
	END
---Inserts the new unit if Dynamically Add nursing units are set to true--

--Check the Unit is Licensed---
	Declare @UnitCode NVARCHAR(20)
	exec [usp_Hl7_GetUnitLicense] 'inHL7','D',@UnitId,@UnitCode out
	if(@UnitCode IS NULL)
	BEGIN
		INSERT INTO Hl7PatientLink(MessageNo,PatientMrn,PatientVisitNumber,PatientId)Values(@MessageNumber,@PatientMrn,@PatientVisitNumber,null);
		RAISERROR ('Unit "%s" is not Licensed for MessageControlId="%s".',16,1,@PatientPointOfCare,@MessageControlId);
		return;
	END
--Check the Unit is Licensed---
END TRY
BEGIN CATCH
	Update [Hl7InboundMessage] set MessageStatus='E' where MessageNo=@MessageNumber;
	DECLARE @ErrorMessage NVARCHAR(4000);DECLARE @ErrorSeverity INT;
	DECLARE @ErrorState INT;
	SELECT  @ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

	RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
	return;
END CATCH
	
BEGIN TRAN
BEGIN TRY
---Get patient GenderCode from the Int_misc_code--
		Declare @PatientGenderCodeId int
		if(@PatientSex is NOT NULL)
		BEGIN
			exec usp_GetCodeByCategoryCode @categoryCd='SEX',@MethodCd='HL7',@Code=@PatientSex,@OrganizationId=@FacilityId,@SendingSysId=@SendingSysId,@CodeId=@PatientGenderCodeId out
			if(@PatientGenderCodeId IS NULL and @DynamicallyAddUSID=1)
			BEGIN
				SET @PatientGenderCodeId=(select CAST(RAND() * 10000 AS INT) AS [RandomNumber])
				WHILE((select code_id from int_misc_code where code_id=@PatientGenderCodeId) is NOT null)
					BEGIN
					 SET @PatientGenderCodeId=@PatientGenderCodeId+1;
					END
				exec usp_InsertMiscCodeDetails @PatientGenderCodeId,@FacilityId,@SendingSysId,'SEX','HL7',@PatientSex;     
			END 
		END
---Get patient GenderCode from the Int_misc_code--       

---Get patient Class from the Int_misc_code--
		Declare @PatientClassCId int
		exec usp_GetCodeByCategoryCode @categoryCd='PCLS',@MethodCd='HL7',@Code=@PatientClass,@OrganizationId=@FacilityId,@SendingSysId=@SendingSysId,@CodeId=@PatientClassCId out
		if(@PatientClassCId IS NULL and @DynamicallyAddUSID=1)
		BEGIN
			SET @PatientClassCId=(select CAST(RAND() * 10000 AS INT) AS [RandomNumber])
			WHILE((select code_id from int_misc_code where code_id=@PatientClassCId) is NOT null)
				BEGIN
				 SET @PatientClassCId=@PatientClassCId+1;
				END
			exec usp_InsertMiscCodeDetails @PatientClassCId,@FacilityId,@SendingSysId,'PCLS','HL7',@PatientClass;     
		END 
---Get patient Class from the Int_misc_code--                                           

--Process Patient Demographic Information--

		declare @PatientId UNIQUEIDENTIFIER,@AcctId UNIQUEIDENTIFIER
		exec usp_HL7_SavePatientDemographicInformation @PatientTypeAccountNo,@PatientMrn,@PatientAccount,@FacilityId,
		@PatientGivenName,@PatientFamilyName,@PatientMiddleName,@PatientDob,@PatientGenderCodeId,@PatientId out,@AcctId out
			--if(@PatientMrn IS NOT null)
			--begin
			--if(@AccountPatientId IS NOT NULL)
			--begin
			----link these 2 records in int_mrn_map.
			--end
--Process Patient Demographic Information--
			
--Process Patient Visit Information--	
		exec [usp_HL7_SavePatientVisitInformation] @UniqueVisitNumber,@UnitId,@FacilityId,@PatientId,
			@SendingSysId,@PatientClassCId,@PatientPointOfCare,@PatientVisitNumber,@MessageNumber,
			@PatientRoom,@PatientBed,@AcctId,@VIPIndicator,@AdmitDateTime,@DischargeDateTime;
--Process Patient Visit Information--	

--link the Hl7 message no and patient mrn 
			INSERT INTO Hl7PatientLink(MessageNo,PatientMrn,PatientVisitNumber,PatientId)Values(@MessageNumber,@PatientMrn,@PatientVisitNumber,@PatientId);
----Link the Hl7 Message no with the patient mrn

----Update the Hl7 Temp table status to received--
			UPDATE [Hl7InboundMessage] set MessageStatus='R' , MessageProcessedDate=getdate() WHERE MessageNo=@MessageNumber;
--Update the Hl7 Temp table status--
COMMIT TRAN;
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	--Update the Hl7 Temp table status to Error--
	Update [Hl7InboundMessage] set MessageStatus='E' where MessageNo=@MessageNumber;
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
