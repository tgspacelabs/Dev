

CREATE PROCEDURE [dbo].[p_ml_Load_Patient_By_Pat_Id]
    (
     @patientID UNIQUEIDENTIFIER
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
        [bsa]
    FROM
        [dbo].[int_patient]
        LEFT OUTER JOIN [dbo].[int_misc_code] ON ([gender_cid] = [code_id])
        INNER JOIN [dbo].[int_mrn_map] ON ([int_patient].[patient_id] = [int_mrn_map].[patient_id])
                                  AND ([merge_cd] = 'C')
        INNER JOIN [dbo].[int_person] ON ([int_patient].[patient_id] = [person_id])
    WHERE
        ([int_mrn_map].[patient_id] = @patientID);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_ml_Load_Patient_By_Pat_Id';

