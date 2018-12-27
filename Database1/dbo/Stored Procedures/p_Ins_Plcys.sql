

CREATE PROCEDURE [dbo].[p_Ins_Plcys]
    (
     @patient_id UNIQUEIDENTIFIER,
     @acct_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

 /* select ins info */
    SELECT DISTINCT
        [I].[cob_priority] [PRIORITY],
        [P].[plan_xid] [PLANNO],
        [I].[ins_policy_xid] [POLICYNO],
        [I].[group_xid] [GROUPNO],
        [I].[seq_no],
        SPACE(50) [LASTNAME],
        SPACE(50) [FIRSTNAME],
        SPACE(50) [MIDDLENAME],
        [I].[holder_rel_cid] [RELATIONSHIPID],
        [I].[holder_id] [HOLDERID],
        SPACE(50) [CARRIER],
        [P].[ins_company_id] [EXT_ORGANIZATION_ID]
    INTO
        [#TMP_INS1]
    FROM
        [dbo].[int_insurance_policy] [I],
        [dbo].[int_insurance_plan] [P]
    WHERE
        [I].[patient_id] = @patient_id
        AND [I].[account_id] = @acct_id
        AND [I].[plan_id] = [P].[plan_id]
    ORDER BY
        [PRIORITY];

  /* update external_org */
    UPDATE
        [#TMP_INS1]
    SET
        [CARRIER] = [E].[organization_nm]
    FROM
        [#TMP_INS1] [A],
        [dbo].[int_external_organization] [E]
    WHERE
        [A].[EXT_ORGANIZATION_ID] = [E].[ext_organization_id];

  /* update from person_name */
    UPDATE
        [#TMP_INS1]
    SET
        [LASTNAME] = ISNULL([last_nm], ''),
        [MIDDLENAME] = ISNULL([middle_nm], ''),
        [FIRSTNAME] = ISNULL([first_nm], '')
    FROM
        [#TMP_INS1],
        [dbo].[int_person_name] [PN]
    WHERE
        [HOLDERID] = [PN].[person_nm_id]
        AND [PN].[recognize_nm_cd] = 'P'
        AND [PN].[active_sw] = 1;

  /* contact person address */
    SELECT
        [I].[PRIORITY],
        [I].[PLANNO],
        [I].[POLICYNO],
        [I].[GROUPNO],
        [I].[seq_no],
        [I].[LASTNAME],
        [I].[FIRSTNAME],
        [I].[MIDDLENAME],
        [I].[RELATIONSHIPID],
        [I].[HOLDERID],
        [I].[CARRIER],
        [I].[EXT_ORGANIZATION_ID],
        [A].[line1_dsc] [ADDR1],
        [A].[line2_dsc] [ADDR2],
        [A].[line3_dsc] [ADDR3],
        [A].[city_nm] [CITY],
        [A].[state_code] [STATE],
        [A].[zip_code] [ZIP],
        [A].[country_cid],
        SPACE(14) [TEL_NO],
        CAST(NULL AS UNIQUEIDENTIFIER) [CONTACT_ID]
    INTO
        [#TMP_INS2]
    FROM
        [#TMP_INS1] [I]
        RIGHT OUTER JOIN [dbo].[int_address] [A] ON ([I].[EXT_ORGANIZATION_ID] = [A].[address_id]);

  /* phone */
    UPDATE
        [#TMP_INS2]
    SET
        [TEL_NO] = [T].[tel_no]
    FROM
        [#TMP_INS2] [I],
        [dbo].[int_telephone] [T]
    WHERE
        [I].[EXT_ORGANIZATION_ID] = [T].[phone_id]
        AND [T].[phone_loc_cd] = 'B'
        AND [T].[phone_type_cd] = 'V'
        AND [T].[seq_no] = (SELECT
                            MIN([seq_no])
                        FROM
                            [dbo].[int_telephone]
                        WHERE
                            [T].[phone_id] = [phone_id]
                            AND [phone_loc_cd] = 'B'
                            AND [phone_type_cd] = 'V'
                       );

  /* contact person  */
    UPDATE
        [#TMP_INS2]
    SET
        [CONTACT_ID] = [IP].[ins_contact_id]
    FROM
        [#TMP_INS2] [I],
        [dbo].[int_insurance_policy] [IP]
    WHERE
        [IP].[patient_id] = @patient_id
        AND [IP].[seq_no] = [I].[seq_no]
        AND [IP].[active_sw] = 1;

    SELECT
        [I].[EXT_ORGANIZATION_ID],
        [I].[CARRIER],
        [I].[HOLDERID],
        [I].[RELATIONSHIPID],
        [I].[MIDDLENAME],
        [I].[FIRSTNAME],
        [I].[LASTNAME],
        [I].[seq_no],
        [I].[GROUPNO],
        [I].[POLICYNO],
        [I].[PLANNO],
        [I].[PRIORITY],
        [I].[ADDR1],
        [I].[ADDR2],
        [I].[ADDR3],
        [I].[CITY],
        [I].[STATE],
        [I].[ZIP],
        [I].[country_cid],
        [I].[TEL_NO],
        [I].[CONTACT_ID],
        [PN].[last_nm] [CO_LNAME],
        [PN].[first_nm] [CO_FNAME],
        [PN].[middle_nm] [CO_MNAME]
    FROM
        [dbo].[int_person_name] [PN]
        RIGHT OUTER JOIN [#TMP_INS2] [I] ON ([I].[CONTACT_ID] = [PN].[person_nm_id])
    WHERE
        [PN].[recognize_nm_cd] = 'P'
        AND [PN].[active_sw] = 1
    ORDER BY
        [I].[PRIORITY];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Ins_Plcys';

