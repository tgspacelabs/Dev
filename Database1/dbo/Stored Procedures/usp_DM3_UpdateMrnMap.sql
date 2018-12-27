
 
CREATE PROCEDURE [dbo].[usp_DM3_UpdateMrnMap]
    (
     @PatientGUID NVARCHAR(50),
     @MainOrgID NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_mrn_map]
    SET
        [adt_adm_sw] = NULL
    WHERE
        [patient_id] = @PatientGUID
        AND [organization_id] = @MainOrgID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_UpdateMrnMap';

