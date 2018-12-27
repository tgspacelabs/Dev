

/* Saves the patient visit Information*/
CREATE PROCEDURE [dbo].[usp_HL7_SavePatientVisitInformation]
    (
     @UniqueVisitNumber BIT,
     @UnitId UNIQUEIDENTIFIER,
     @OrganizationId UNIQUEIDENTIFIER,
     @PatientId UNIQUEIDENTIFIER,
     @SendingApplicationId UNIQUEIDENTIFIER,
     @PatientClassCid INT,
     @PatientPointOfCare NVARCHAR(80),
     @PatientVisitNumber NVARCHAR(20),
     @MessageNumber INT,
     @PatientRoom NVARCHAR(80) = NULL,
     @PatientBed NCHAR(80) = NULL,
     @AccountId UNIQUEIDENTIFIER = NULL,
     @VIPIndicator NCHAR(2) = NULL,
     @AdmitDateTime DATETIME = NULL,
     @DischargeDateTime DATETIME = NULL
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

        DECLARE
            @VisitNumberExists INT,
            @EncounterId UNIQUEIDENTIFIER,
            @StatusCode NVARCHAR(6);
        SET @StatusCode = 'C';
        IF @DischargeDateTime IS NOT NULL
        BEGIN
            SET @StatusCode = 'D';
        END;
        SET @VisitNumberExists = (SELECT
                                    COUNT(1)
                                  FROM
                                    [dbo].[int_encounter_map]
                                  WHERE
                                    [encounter_xid] = @PatientVisitNumber
                                    AND [organization_id] = @OrganizationId
                                 );
        IF (@VisitNumberExists > 0)
        BEGIN
            SET @EncounterId = (SELECT
                                    [encounter_id]
                                FROM
                                    [dbo].[int_encounter_map]
                                WHERE
                                    [encounter_xid] = @PatientVisitNumber
                                    AND [organization_id] = @OrganizationId
                                    AND [patient_id] = @PatientId
                               );
            IF NOT EXISTS ( SELECT
                                [patient_id]
                            FROM
                                [dbo].[int_encounter_map]
                            WHERE
                                [encounter_xid] = @PatientVisitNumber
                                AND [organization_id] = @OrganizationId
                                AND [patient_id] = @PatientId )
            BEGIN
        		--Gets the Existing Encounter ID
                IF (@UniqueVisitNumber = 1)
                BEGIN
                    RAISERROR ('VisitNumber = "%s" already exists in the database for a different patient,change visit number for MessageControlId="%s".',16,1,@PatientVisitNumber,@MessageControlId);
                    RETURN;
                END;
                ELSE
                BEGIN
                    SET @EncounterId = NEWID();

		        	--only begin_dt is not stored from pre release which is from MSH in int_encounter
                    INSERT  INTO [dbo].[int_encounter]
                            ([encounter_id],
                             [organization_id],
                             [mod_dt],
                             [patient_id],
                             [status_cd],
                             [account_id]
                            )
                    VALUES
                            (@EncounterId,
                             @OrganizationId,
                             GETDATE(),
                             @PatientId,
                             @StatusCode,
                             @AccountId
                            );
						
                    INSERT  INTO [dbo].[int_encounter_map]
                            ([encounter_xid],
                             [organization_id],
                             [encounter_id],
                             [patient_id],
                             [seq_no],
                             [status_cd],
                             [account_id]
                            )
                    VALUES
                            (@PatientVisitNumber,
                             @OrganizationId,
                             @EncounterId,
                             @PatientId,
                             '1',
                             @StatusCode,
                             @AccountId
                            );
                END;
            END;
        END;
        ELSE
        BEGIN
            SET @EncounterId = NEWID();
            INSERT  INTO [dbo].[int_encounter]
                    ([encounter_id],
                     [organization_id],
                     [mod_dt],
                     [patient_id],
                     [status_cd],
                     [account_id]
                    )
            VALUES
                    (@EncounterId,
                     @OrganizationId,
                     GETDATE(),
                     @PatientId,
                     @StatusCode,
                     @AccountId
                    );
						
            INSERT  INTO [dbo].[int_encounter_map]
                    ([encounter_xid],
                     [organization_id],
                     [encounter_id],
                     [patient_id],
                     [seq_no],
                     [status_cd],
                     [account_id]
                    )
            VALUES
                    (@PatientVisitNumber,
                     @OrganizationId,
                     @EncounterId,
                     @PatientId,
                     '1',
                     @StatusCode,
                     @AccountId
                    );
        END;
	
    	--Update Encounter information--
		--@PatientTypeCid int=null,@PatientClassCid int=null,@MessageDateTime datetime=null why do we need this parameters here
        EXEC [dbo].[usp_HL7_UpdatePatientVisitInformation] @EncounterId = @EncounterId, @AccountId = @AccountId, @StatusCd = @StatusCode, @VipSw = @VIPIndicator, @PatientClassCid = @PatientClassCid, @UnitOrgId = @UnitId, @AdmitDt = @AdmitDateTime, @Rm = @PatientRoom, @Bed = @PatientBed, @DischargeDt = @DischargeDateTime;
	
	--Update Encounter information--
	
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
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
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Saves the patient visit Information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_SavePatientVisitInformation';

