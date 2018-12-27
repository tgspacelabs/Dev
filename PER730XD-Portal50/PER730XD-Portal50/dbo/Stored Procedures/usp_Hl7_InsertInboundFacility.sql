 
 /* This procedure returns the Organization_id, if the sending facility exists in the category code 'F'.
 if not exists and Dynamically Add Organizations is set to True, it will add the organization in the table.*/
 CREATE PROCEDURE [dbo].[usp_Hl7_InsertInboundFacility]
 (
     @SendingFacility NVARCHAR(180),
     @DynAddOrgs bit,
     @FacilityId UNIQUEIDENTIFIER=null out
 )
 AS
 BEGIN
 BEGIN TRY
     SET @FacilityId=(SELECT organization_id from int_organization WHERE category_cd='F' AND organization_cd=@SendingFacility);
     IF(@FacilityId IS NULL AND @DynAddOrgs=1)
         BEGIN
            DECLARE @PrimaryOrganization UNIQUEIDENTIFIER,@orgId UNIQUEIDENTIFIER;
            SET @orgId=NEWID()--we will make this as constraint
            SET @PrimaryOrganization=(SELECT Organization_id FROM int_organization WHERE category_cd='O');
            EXEC usp_InsertOrganizationInformation @organizationId=@orgId,@categoryCd='F',@parentOrganizationId=@PrimaryOrganization,@organizationCd=@SendingFacility,@organizationNm=@SendingFacility;
            SET @FacilityId=@orgId;
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
