

/*[usp_InsertEncounterMapInformation] used to insert Encounter map information*/
CREATE PROCEDURE [dbo].[usp_InsertEncounterMapInformation]
    (
     @EncounterXid NVARCHAR(80),
     @OrgId UNIQUEIDENTIFIER,
     @EncounterId UNIQUEIDENTIFIER,
     @PatientId UNIQUEIDENTIFIER,
     @SeqNo INT,
     @OrgPatientId UNIQUEIDENTIFIER = NULL,
     @StatusCd NCHAR(2) = NULL,
     @EventCd NVARCHAR(8) = NULL,
     @AccountId UNIQUEIDENTIFIER = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_encounter_map]
            ([encounter_xid],
             [organization_id],
             [encounter_id],
             [patient_id],
             [seq_no],
             [orig_patient_id],
             [status_cd],
             [event_cd],
             [account_id]
	        )
    VALUES
            (@EncounterXid,
             @OrgId,
             @EncounterId,
             @PatientId,
             @SeqNo,
             @OrgPatientId,
             @StatusCd,
             @EventCd,
             @AccountId
	        );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Insert Encounter map information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_InsertEncounterMapInformation';

