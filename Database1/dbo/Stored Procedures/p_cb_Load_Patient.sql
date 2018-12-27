

CREATE PROCEDURE [dbo].[p_cb_Load_Patient]
    (
     @PatientId VARCHAR(38),
     @EncounterId VARCHAR(38),
     @OwnerId VARCHAR(38),
     @ListType CHAR(20)
    )
AS
BEGIN
    SET NOCOUNT ON;

    --- OwnerId <> '' & ListType <> 'UNIT'
    IF (@OwnerId <> ''
        AND @ListType <> 'UNIT'
        )
    BEGIN
        SELECT
            [person_id],
            [int_person].[last_nm],
            [int_person].[first_nm],
            [int_person].[middle_nm],
            [suffix],
            [gender_cid],
            [dob],
            [O2].[organization_cd] AS [DEPARTMENT_CD],
            [rm],
            [bed],
            [med_svc_cid],
            [mrn_xid],
            [vip_sw],
            [admit_dt],
            [discharge_dt],
            [begin_dt],
            [int_encounter].[encounter_id],
            [int_encounter].[status_cd],
            [patient_class_cid],
            [patient_type_cid],
            [O1].[organization_cd],
            [O1].[organization_nm],
            [int_hcp].[last_nm] AS [HCP_LNAME],
            [int_hcp].[first_nm] AS [HCP_FNAME],
            [ssn],
            [encounter_xid],
            [new_results],
            [viewed_results_dt],
            [int_patient_list_detail].[patient_list_id],
            [int_encounter].[organization_id]
        FROM
            [dbo].[int_encounter]
            LEFT OUTER JOIN [dbo].[int_hcp] ON ([attend_hcp_id] = [hcp_id])
            LEFT OUTER JOIN [dbo].[int_organization] [O1] ON ([int_encounter].[organization_id] = [O1].[organization_id])
            LEFT OUTER JOIN [dbo].[int_organization] [O2] ON ([unit_org_id] = [O2].[organization_id])
            INNER JOIN [dbo].[int_encounter_map] ON ([int_encounter].[encounter_id] = [int_encounter_map].[encounter_id])
            INNER JOIN [dbo].[int_patient_list_detail] ON ([int_encounter].[encounter_id] = [int_patient_list_detail].[encounter_id])
            INNER JOIN [dbo].[int_patient_list] ON ([int_patient_list_detail].[patient_list_id] = [int_patient_list].[patient_list_id])
            INNER JOIN [dbo].[int_person] ON ([int_patient_list_detail].[patient_id] = [person_id])
            INNER JOIN [dbo].[int_patient] ON ([person_id] = [int_patient].[patient_id])
            INNER JOIN [dbo].[int_mrn_map] ON ([person_id] = [int_mrn_map].[patient_id])
        WHERE
            ([int_encounter].[encounter_id] = @EncounterId)
            AND ([merge_cd] = 'C')
            AND ([person_id] = @PatientId)
            AND ([O2].[organization_id] = @OwnerId);

    END;
    -- OWnerId <> '' ListType = 'UNIT'
    ELSE
        IF (@OwnerId <> ''
            AND @ListType = 'UNIT'
            )
        BEGIN
            SELECT
                [person_id],
                [int_person].[last_nm],
                [int_person].[first_nm],
                [int_person].[middle_nm],
                [suffix],
                [gender_cid],
                [dob],
                [O2].[organization_cd] AS [DEPARTMENT_CD],
                [rm],
                [bed],
                [med_svc_cid],
                [mrn_xid],
                [vip_sw],
                [admit_dt],
                [discharge_dt],
                [begin_dt],
                [int_encounter].[encounter_id],
                [int_encounter].[status_cd],
                [patient_class_cid],
                [patient_type_cid],
                [O1].[organization_cd],
                [O1].[organization_nm],
                [int_hcp].[last_nm] AS [HCP_LNAME],
                [int_hcp].[first_nm] AS [HCP_FNAME],
                [ssn],
                [encounter_xid],
                [int_encounter].[organization_id]
            FROM
                [dbo].[int_encounter]
                LEFT OUTER JOIN [dbo].[int_hcp] ON ([attend_hcp_id] = [hcp_id])
                LEFT OUTER JOIN [dbo].[int_organization] [O2] ON ([unit_org_id] = [O2].[organization_id])
                INNER JOIN [dbo].[int_encounter_map] ON ([int_encounter].[encounter_id] = [int_encounter_map].[encounter_id])
                INNER JOIN [dbo].[int_organization] [O1] ON ([int_encounter].[organization_id] = [O1].[organization_id]),
                [dbo].[int_person]
                INNER JOIN [dbo].[int_patient] ON ([person_id] = [int_patient].[patient_id])
                INNER JOIN [dbo].[int_mrn_map] ON ([person_id] = [int_mrn_map].[patient_id])
            WHERE
                ([int_encounter].[encounter_id] = @EncounterId)
                AND ([merge_cd] = 'C')
                AND ([person_id] = @PatientId)
                AND ([O2].[organization_id] = @OwnerId);
        END;
        ELSE
        BEGIN
        -- OwnerId = ''
            SELECT
                [person_id],
                [int_person].[last_nm],
                [int_person].[first_nm],
                [int_person].[middle_nm],
                [suffix],
                [gender_cid],
                [dob],
                [O2].[organization_cd] AS [DEPARTMENT_CD],
                [rm],
                [bed],
                [med_svc_cid],
                [mrn_xid],
                [vip_sw],
                [admit_dt],
                [discharge_dt],
                [begin_dt],
                [int_encounter].[encounter_id],
                [int_encounter].[status_cd],
                [patient_class_cid],
                [patient_type_cid],
                [O1].[organization_cd],
                [O1].[organization_nm],
                [int_hcp].[last_nm] AS [HCP_LNAME],
                [int_hcp].[first_nm] AS [HCP_FNAME],
                [ssn],
                [encounter_xid],
                [int_encounter].[organization_id]
            FROM
                [dbo].[int_encounter]
                LEFT OUTER JOIN [dbo].[int_hcp] ON ([attend_hcp_id] = [hcp_id])
                LEFT OUTER JOIN [dbo].[int_organization] [O1] ON ([int_encounter].[encounter_id] = [O1].[organization_id])
                LEFT OUTER JOIN [dbo].[int_organization] [O2] ON ([unit_org_id] = [O2].[organization_id])
                INNER JOIN [dbo].[int_encounter_map] ON ([int_encounter].[encounter_id] = [int_encounter_map].[encounter_id]),
                [dbo].[int_person]
                INNER JOIN [dbo].[int_patient] ON ([person_id] = [int_patient].[patient_id])
                INNER JOIN [dbo].[int_mrn_map] ON ([person_id] = [int_mrn_map].[patient_id])
            WHERE
                ([int_encounter].[encounter_id] = @EncounterId)
                AND ([merge_cd] = 'C')
                AND ([person_id] = @PatientId);
        END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_cb_Load_Patient';

