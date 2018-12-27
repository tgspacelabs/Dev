
/* [usp_InsertMrnInformation] is used to Insert the patient MRN Information from any component
@organizationId,@mrn1 is mandatory and the remaining are optional with default NULL values*/
CREATE PROCEDURE [dbo].[usp_InsertMrnInformation]
(
    @organizationId UNIQUEIDENTIFIER,
    @mrn1 NVARCHAR(60),
    @patientId UNIQUEIDENTIFIER,
    @orgPatientId UNIQUEIDENTIFIER=null,
    @priorPatientId UNIQUEIDENTIFIER=null,
    @mrn2 NVARCHAR(60)=null,
    @AdtAdmsw tinyint=null
)
AS
BEGIN
INSERT INTO 
int_mrn_map 
    (
    organization_id, 
    mrn_xid, 
    patient_id, 
    orig_patient_id,
    merge_cd,
    prior_patient_id,
    mrn_xid2, 
    adt_adm_sw
    )
VALUES 
    (
    @organizationId, 
    @mrn1,
    @patientId, 
    @orgPatientId, 
    'C',
    @priorPatientId,
    @mrn2,
    @AdtAdmsw 
    )
END
