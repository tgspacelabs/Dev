

/* Saves ADT A01 message*/
CREATE PROCEDURE [dbo].[usp_Hl7_SaveADTMessage]
    (
     @MessageNumber INT,
	/*Configuration settings*/
     @DynAddOrgs BIT,
     @DynAddSendingSys BIT,
     @PatientTypeAccountNo BIT,
     @UniqueVisitNumber BIT,
     @DynamicallyAddNursingUnits BIT,
     @DynamicallyAddUSID BIT,
	/*Configuration settings*/

	/*Msh(organization Information)*/
     @SendingSystem NVARCHAR(180),
     @SendingFacility NVARCHAR(180),
	/*Msh(organization Information)*/
	
	/*Patient Demographic information*/
     @PatientMrn NVARCHAR(20),
     @PatientAccount NVARCHAR(20) = NULL,
     @PatientGivenName NVARCHAR(48) = NULL,
     @PatientFamilyName NVARCHAR(48) = NULL,
     @PatientMiddleName NVARCHAR(48) = NULL,
     @PatientDob DATETIME = NULL,
     @PatientSex NVARCHAR(1) = NULL,
	/*Patient Demographic information*/

	/*Patient Visit Information*/
     @PatientClass NVARCHAR(1),
     @PatientPointOfCare NVARCHAR(80),
     @PatientVisitNumber NVARCHAR(20),
     @PatientRoom NVARCHAR(80) = NULL,
     @PatientBed NVARCHAR(80) = NULL,
     @VIPIndicator NCHAR(2) = NULL,
     @AdmitDateTime DATETIME = NULL,
     @DischargeDateTime DATETIME = NULL
	/*Patient Visit Information*/
    )
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
--Getting the Message Control Id from the message No
        DECLARE @MessageControlId NVARCHAR(10);
        SET @MessageControlId = (SELECT
                                    [MessageControlId]
                                 FROM
                                    [dbo].[Hl7InboundMessage]
                                 WHERE
                                    [MessageNo] = @MessageNumber
                                );
--Getting the Message Control Id from the message No

--Checking the facility and sending system existing in the current system, if not returing the error message.
        DECLARE
            @FacilityId UNIQUEIDENTIFIER,
            @SendingSysId UNIQUEIDENTIFIER;
        EXEC [dbo].[usp_Hl7_InsertInboundFacility] @SendingFacility, @DynAddOrgs, @FacilityId OUT;
        IF (@FacilityId IS NOT NULL)
        BEGIN 
            EXEC [dbo].[usp_Hl7_InsertInboundSendingSystem] @SendingSystem, @DynAddSendingSys, @FacilityId, @SendingSysId OUT;
        END;
        IF (@FacilityId IS NULL
            OR @SendingSysId IS NULL
            )
        BEGIN
            INSERT  INTO [dbo].[Hl7PatientLink]
                    ([MessageNo],
                     [PatientMrn],
                     [PatientVisitNumber],
                     [PatientId]
                    )
            VALUES
                    (@MessageNumber,
                     @PatientMrn,
                     @PatientVisitNumber,
                     NULL
                    );
            RAISERROR (N'Sending Application "%s" or Sending Facility "%s" is not present at the database for MessageControlId="%s".',16,1,@SendingSystem,@SendingFacility,@MessageControlId);
            RETURN;
        END;
--Checking the facility and sending system existing in the current system, if not returing the error message.

---Inserts the new unit if Dynamically Add nursing units are set to true--
        DECLARE @UnitId UNIQUEIDENTIFIER;
        SET @UnitId = (SELECT
                        [organization_id]
                       FROM
                        [dbo].[int_organization]
                       WHERE
                        [category_cd] = 'D'
                        AND [organization_cd] = @PatientPointOfCare
                        AND [parent_organization_id] = @FacilityId
                      );
        IF (@UnitId IS NULL)
        BEGIN
            IF (@DynamicallyAddNursingUnits = 1)
            BEGIN
                SET @UnitId = NEWID();
                EXEC [dbo].[usp_InsertOrganizationInformation] @organizationId = @UnitId, @categoryCd = 'D', @autoCollectInterval = 1, @parentOrganizationId = @FacilityId, @organizationCd = @PatientPointOfCare, @organizationNm = @PatientPointOfCare;
            END;
            ELSE
            BEGIN
                INSERT  INTO [dbo].[Hl7PatientLink]
                        ([MessageNo],
                         [PatientMrn],
                         [PatientVisitNumber],
                         [PatientId]
                        )
                VALUES
                        (@MessageNumber,
                         @PatientMrn,
                         @PatientVisitNumber,
                         NULL
                        );
                RAISERROR ('Facility for "%s" unit is not present at the database or DynAddNursingUnits configuration is set to false for MessageControlId="%s".',16,1,@PatientPointOfCare,@MessageControlId);
                RETURN;
            END;
        END;
---Inserts the new unit if Dynamically Add nursing units are set to true--

--Check the Unit is Licensed---
        DECLARE @UnitCode NVARCHAR(20);
        EXEC [dbo].[usp_Hl7_GetUnitLicense] 'inHL7', 'D', @UnitId, @UnitCode OUT;
        IF (@UnitCode IS NULL)
        BEGIN
            INSERT  INTO [dbo].[Hl7PatientLink]
                    ([MessageNo],
                     [PatientMrn],
                     [PatientVisitNumber],
                     [PatientId]
                    )
            VALUES
                    (@MessageNumber,
                     @PatientMrn,
                     @PatientVisitNumber,
                     NULL
                    );
            RAISERROR ('Unit "%s" is not Licensed for MessageControlId="%s".',16,1,@PatientPointOfCare,@MessageControlId);
            RETURN;
        END;
--Check the Unit is Licensed---
    END TRY
    BEGIN CATCH
        UPDATE
            [dbo].[Hl7InboundMessage]
        SET
            [MessageStatus] = 'E'
        WHERE
            [MessageNo] = @MessageNumber;
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
        RETURN;
    END CATCH;
	
    BEGIN TRAN;
    BEGIN TRY
---Get patient GenderCode from the Int_misc_code--
        DECLARE @PatientGenderCodeId INT;
        IF (@PatientSex IS NOT NULL)
        BEGIN
            EXEC [dbo].[usp_GetCodeByCategoryCode] @categoryCd = 'SEX', @MethodCd = 'HL7', @Code = @PatientSex, @OrganizationId = @FacilityId, @SendingSysId = @SendingSysId, @CodeId = @PatientGenderCodeId OUT;
            IF (@PatientGenderCodeId IS NULL
                AND @DynamicallyAddUSID = 1
                )
            BEGIN
                SET @PatientGenderCodeId = (SELECT
                                                CAST(RAND() * 10000 AS INT) AS [RandomNumber]
                                           );
                WHILE ((SELECT
                            [code_id]
                        FROM
                            [dbo].[int_misc_code]
                        WHERE
                            [code_id] = @PatientGenderCodeId
                       ) IS NOT NULL)
                BEGIN
                    SET @PatientGenderCodeId = @PatientGenderCodeId + 1;
                END;
                EXEC [dbo].[usp_InsertMiscCodeDetails] @PatientGenderCodeId, @FacilityId, @SendingSysId, 'SEX', 'HL7', @PatientSex;     
            END; 
        END;
---Get patient GenderCode from the Int_misc_code--       

---Get patient Class from the Int_misc_code--
        DECLARE @PatientClassCId INT;
        EXEC [dbo].[usp_GetCodeByCategoryCode] @categoryCd = 'PCLS', @MethodCd = 'HL7', @Code = @PatientClass, @OrganizationId = @FacilityId, @SendingSysId = @SendingSysId, @CodeId = @PatientClassCId OUT;
        IF (@PatientClassCId IS NULL
            AND @DynamicallyAddUSID = 1
            )
        BEGIN
            SET @PatientClassCId = (SELECT
                                        CAST(RAND() * 10000 AS INT) AS [RandomNumber]
                                   );
            WHILE ((SELECT
                        [code_id]
                    FROM
                        [dbo].[int_misc_code]
                    WHERE
                        [code_id] = @PatientClassCId
                   ) IS NOT NULL)
            BEGIN
                SET @PatientClassCId = @PatientClassCId + 1;
            END;
            EXEC [dbo].[usp_InsertMiscCodeDetails] @PatientClassCId, @FacilityId, @SendingSysId, 'PCLS', 'HL7', @PatientClass;     
        END; 
---Get patient Class from the Int_misc_code--                                           

--Process Patient Demographic Information--

        DECLARE
            @PatientId UNIQUEIDENTIFIER,
            @AcctId UNIQUEIDENTIFIER;
        EXEC [dbo].[usp_HL7_SavePatientDemographicInformation] @PatientTypeAccountNo, @PatientMrn, @PatientAccount, @FacilityId, @PatientGivenName, @PatientFamilyName, @PatientMiddleName, @PatientDob, @PatientGenderCodeId, @PatientId OUT, @AcctId OUT;
			--if(@PatientMrn IS NOT null)
			--begin
			--if(@AccountPatientId IS NOT NULL)
			--begin
			----link these 2 records in int_mrn_map.
			--end
--Process Patient Demographic Information--
			
--Process Patient Visit Information--	
        EXEC [dbo].[usp_HL7_SavePatientVisitInformation] @UniqueVisitNumber, @UnitId, @FacilityId, @PatientId, @SendingSysId, @PatientClassCId, @PatientPointOfCare, @PatientVisitNumber, @MessageNumber, @PatientRoom, @PatientBed, @AcctId, @VIPIndicator, @AdmitDateTime, @DischargeDateTime;
--Process Patient Visit Information--	

--link the Hl7 message no and patient mrn 
        INSERT  INTO [dbo].[Hl7PatientLink]
                ([MessageNo],
                 [PatientMrn],
                 [PatientVisitNumber],
                 [PatientId]
                )
        VALUES
                (@MessageNumber,
                 @PatientMrn,
                 @PatientVisitNumber,
                 @PatientId
                );
----Link the Hl7 Message no with the patient mrn

----Update the Hl7 Temp table status to received--
        UPDATE
            [dbo].[Hl7InboundMessage]
        SET
            [MessageStatus] = 'R',
            [MessageProcessedDate] = GETDATE()
        WHERE
            [MessageNo] = @MessageNumber;
--Update the Hl7 Temp table status--
        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
	--Update the Hl7 Temp table status to Error--
        UPDATE
            [dbo].[Hl7InboundMessage]
        SET
            [MessageStatus] = 'E'
        WHERE
            [MessageNo] = @MessageNumber;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

	-- Use RAISERROR inside the CATCH block to return error
	-- information about the original error that caused
	-- execution to jump to the CATCH block.
        RAISERROR (@ErrorMessage, -- Message text.
			   @ErrorSeverity, -- Severity.
			   @ErrorState -- State.
			   );
    END CATCH;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Saves ADT A01 message.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_Hl7_SaveADTMessage';

