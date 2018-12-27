
 /* This procedure returns the SendingSystemId from the sending system table with organization id
 if not exists and Dynamically sending system is set to True, it will add the system system  in the table.
 */
 CREATE PROCEDURE [dbo].[usp_Hl7_InsertInboundSendingSystem]
 (
	@SendingSystem NVARCHAR(180),
	@DynAddSendingSys bit,
	@OrganizationId UNIQUEIDENTIFIER,
	@SendingSysId UNIQUEIDENTIFIER=null out
 )
 AS
 BEGIN
BEGIN TRY
	 SET @SendingSysId=(SELECT sys_id FROM int_send_sys WHERE code=@SendingSystem AND organization_id=@OrganizationId);
	 IF(@SendingSysId IS NULL AND @DynAddSendingSys=1)
		 BEGIN
			DECLARE @SendSysId UNIQUEIDENTIFIER;
			SET @SendSysId=NEWID()--we will make this as constraint
			EXEC usp_InsertSendingSystemInformation @SendSysId,@OrganizationId,@SendingSystem,null
			SET @SendingSysId=@SendSysId;--need to change this to scope_identity
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

