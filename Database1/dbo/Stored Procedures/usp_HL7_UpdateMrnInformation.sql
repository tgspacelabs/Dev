


CREATE PROCEDURE [dbo].[usp_HL7_UpdateMrnInformation]
    (
     @mrn1 NVARCHAR(60),
     @patientId UNIQUEIDENTIFIER,
     @mrn2 NVARCHAR(60)
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_mrn_map]
    SET
        [mrn_xid] = @mrn1,
        [mrn_xid2] = @mrn2
    WHERE
        [patient_id] = @patientId
        AND [merge_cd] <> 'L';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_UpdateMrnInformation';

