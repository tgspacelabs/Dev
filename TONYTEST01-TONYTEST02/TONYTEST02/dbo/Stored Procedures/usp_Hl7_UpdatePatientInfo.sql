
/*Updates patient Demographics related to Hl7 tables*/
CREATE PROCEDURE [dbo].[usp_Hl7_UpdatePatientInfo]
(
	
	@PatientId UNIQUEIDENTIFIER,
	@mrn1 NVARCHAR(20),
	@mrn2 NVARCHAR(20)=NULL,
	@FirstNm  NVARCHAR(48) = NULL, 
	@MiddleNm NVARCHAR(48) = NULL, 
	@LastNm   NVARCHAR(48) = NULL,
	@dob DATETIME=NULL,
	@GenderCid INT =NULL
)
AS
BEGIN
BEGIN TRY
	/*Updates MRN information*/
	Update int_mrn_map set mrn_xid=@mrn1,mrn_xid2=@mrn2 where patient_id=@PatientId;
		
	
	/*Updates Patient information*/
	Update int_patient set dob=@dob,gender_cid=@GenderCid where patient_id=@PatientId;
	
	
	/*Inserts Person information*/
	Update int_person set first_nm=@FirstNm,middle_nm=@MiddleNm,last_nm=@LastNm where person_id=@PatientId
	
	/*Update the patient monitor if it is a active patient*/
	if((SELECT patient_id FROM int_patient_monitor WHERE patient_id = @PatientId AND active_sw = 1) is NOT NULL)
	BEGIN	--Update the patient monitor status to update with patient Updater
		UPDATE int_patient_monitor SET monitor_status = 'UPD' where patient_id = @PatientId AND active_sw = 1
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

