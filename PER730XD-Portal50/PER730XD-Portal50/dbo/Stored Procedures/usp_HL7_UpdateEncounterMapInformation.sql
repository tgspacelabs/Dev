
CREATE PROCEDURE [dbo].[usp_HL7_UpdateEncounterMapInformation]
(
    @EncounterId UNIQUEIDENTIFIER,
    @AccountId UNIQUEIDENTIFIER
)
AS
BEGIN
    UPDATE int_encounter_map
    SET
    account_id=@AccountId
    WHERE encounter_id=@EncounterId
END
