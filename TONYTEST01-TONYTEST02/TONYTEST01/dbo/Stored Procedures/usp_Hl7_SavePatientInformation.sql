
/*Insert Hl7 patient information*/
CREATE PROCEDURE [dbo].[usp_Hl7_SavePatientInformation]
(
	@organizationId UNIQUEIDENTIFIER,
	@patientId UNIQUEIDENTIFIER,
	@mrn1 NVARCHAR(20),
	@mrn2 NVARCHAR(20)=NULL,
	@FirstNm  NVARCHAR(48) = NULL, 
	@MiddleNm NVARCHAR(48) = NULL, 
	@LastNm   NVARCHAR(48) = NULL,
	@dob DATETIME=NULL,
	@GenderCid INT =NULL,
	@AccountId UNIQUEIDENTIFIER out
)
AS
BEGIN
BEGIN TRY
	/*Inserts MRN information*/
	INSERT INTO int_mrn_map 
		(organization_id, mrn_xid, patient_id,mrn_xid2,merge_cd,adt_adm_sw)
	VALUES 
		(@organizationId,@mrn1,@patientId, @mrn2,'C',1);
	
	/*Inserts Patient information*/
	INSERT Into int_patient(patient_id,dob,gender_cid)
					values(@patientId,@dob,@GenderCid);
					
	--/*Inserts Person information*/
	INSERT Into int_person(person_id,first_nm,middle_nm,last_nm)
					values(@patientId,@FirstNm,@MiddleNm,@LastNm);
	
	
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
