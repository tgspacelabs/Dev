


-- [GetPatientInformation] is used to get the patient demographics in DM3 Loader
CREATE PROCEDURE [dbo].[GetPatientInformation]
    (
     @patientId NVARCHAR(50) = NULL,
     @OrgId NVARCHAR(50) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [int_mrn_map].[patient_id],
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
        (SELECT
            [ID1] = @patientId,
            [OrgId] = @OrgId
        ) [WantedPatient]
        LEFT OUTER JOIN [dbo].[int_mrn_map] ON [WantedPatient].[ID1] = [mrn_xid]
                                               AND [WantedPatient].[OrgId] = [int_mrn_map].[organization_id]
        LEFT OUTER JOIN [dbo].[int_person] ON [int_mrn_map].[patient_id] = [person_id]
        LEFT OUTER JOIN [dbo].[int_patient] ON [int_patient].[patient_id] = [int_mrn_map].[patient_id]
        LEFT OUTER JOIN [dbo].[int_misc_code] ON [code_id] = [gender_cid];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the patient demographics in DM3 Loader.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientInformation';

