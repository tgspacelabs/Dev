
/*[usp_InsertEncounterMapInformation] used to insert Encounter map information*/
CREATE PROCEDURE [dbo].[usp_InsertEncounterMapInformation]
(
	@EncounterXid NVARCHAR(80),
	@OrgId UNIQUEIDENTIFIER,
	@EncounterId UNIQUEIDENTIFIER,
	@PatientId UNIQUEIDENTIFIER,
	@SeqNo int,
	@OrgPatientId UNIQUEIDENTIFIER=null,
	@StatusCd nchar(2)=null,
	@EventCd NVARCHAR(8)=null,
	@AccountId UNIQUEIDENTIFIER=null
)
AS
BEGIN
	INSERT INTO dbo.int_encounter_map
	(
	encounter_xid,
	organization_id,
	encounter_id,
	patient_id,
	seq_no,
	orig_patient_id,
	status_cd,
	event_cd,
	account_id
	)
	VALUES
	(
	@encounterXid,
	@orgId,
	@encounterId,
	@patientId,
	@seqNo,
	@orgPatientId,
	@statusCd,
	@eventcd,
	@accountId
	)
END
