


CREATE PROCEDURE [dbo].[usp_DM3_GetPatientInformation]
    (
     @patientId NVARCHAR(50) = NULL,
     @OrgId NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_patient].[patient_id],
        [last_nm],
        [first_nm],
        [middle_nm],
        [mrn_xid],
        [mrn_xid2],
        [int_mrn_map].[organization_id],
        [dob],
        [gender_cid],
        [code],
        [height],
        [weight],
        [bsa],
        [adt_adm_sw]
    FROM
        [dbo].[int_patient]
        INNER JOIN [dbo].[int_mrn_map] ON [int_patient].[patient_id] = [int_mrn_map].[patient_id]
        INNER JOIN [dbo].[int_person] ON [int_patient].[patient_id] = [person_id]
        LEFT OUTER JOIN [dbo].[int_misc_code] ON [gender_cid] = [code_id]
    WHERE
        [mrn_xid] = @patientId
        AND [int_mrn_map].[organization_id] = @OrgId
        AND [merge_cd] = 'C';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_DM3_GetPatientInformation';

