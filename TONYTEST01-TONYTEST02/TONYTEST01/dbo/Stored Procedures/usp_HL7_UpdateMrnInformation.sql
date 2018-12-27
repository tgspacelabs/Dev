

CREATE PROCEDURE [dbo].[usp_HL7_UpdateMrnInformation]
(
	@mrn1 NVARCHAR(60),
	@patientId UNIQUEIDENTIFIER,
	@mrn2 NVARCHAR(60)
)
AS
BEGIN
UPDATE int_mrn_map 
SET 
	mrn_xid=@mrn1,
	mrn_xid2=@mrn2
	WHERE patient_id=@patientId AND merge_cd <> 'L'
END
