

/* [usp_InsertMrnInformation] is used to Insert the patient MRN Information from any component
@organizationId,@mrn1 is mandatory and the remaining are optional with default NULL values*/
CREATE PROCEDURE [dbo].[usp_InsertMrnInformation]
    (
     @organizationId UNIQUEIDENTIFIER,
     @mrn1 NVARCHAR(60),
     @patientId UNIQUEIDENTIFIER,
     @orgPatientId UNIQUEIDENTIFIER = NULL,
     @priorPatientId UNIQUEIDENTIFIER = NULL,
     @mrn2 NVARCHAR(60) = NULL,
     @AdtAdmsw TINYINT = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_mrn_map]
            ([organization_id],
             [mrn_xid],
             [patient_id],
             [orig_patient_id],
             [merge_cd],
             [prior_patient_id],
             [mrn_xid2],
             [adt_adm_sw]
	        )
    VALUES
            (@organizationId,
             @mrn1,
             @patientId,
             @orgPatientId,
             'C',
             @priorPatientId,
             @mrn2,
             @AdtAdmsw 
	        );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Insert the patient MRN Information from any component @organizationId, @mrn1 is mandatory and the remaining are optional with default NULL values', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_InsertMrnInformation';

