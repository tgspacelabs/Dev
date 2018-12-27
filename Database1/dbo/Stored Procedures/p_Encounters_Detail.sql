
-- For Localizing the Not Available string
CREATE PROCEDURE [dbo].[p_Encounters_Detail]
    (
     @patient_id UNIQUEIDENTIFIER,
     @strNotAvail VARCHAR(100)
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @acct_no CHAR(40) = 'SEE DETAIL',
        @short_dsc VARCHAR(50) = '',
        @diagnosis VARCHAR(255) = ' ',
        @pat_type VARCHAR(30) = '',
        @pat_class VARCHAR(30) = '';

    SELECT DISTINCT
        @acct_no AS [TMP_ACCT_XID],
        [A].[account_id] AS [TMP_ACCT_ID],
        [A].[encounter_id] AS [TMP_ENC_ID],
        [C].[encounter_xid] AS [TMP_ENC_XID],
        [A].[patient_type_cid] AS [TMP_PAT_TYPE_ID],
        @pat_type AS [TMP_PAT_TYPE],
        [A].[patient_class_cid] AS [TMP_PAT_CLASS_ID],
        @pat_class AS [TMP_PAT_CLASS],
        [A].[admit_dt] AS [TMP_ADMIT_DT],
        [A].[discharge_dt] AS [TMP_DISCH_DT],
        [A].[med_svc_cid] AS [TMP_MED_SRVC_ID],
        SPACE(20) AS [TMP_MED_SRVC],
        0 AS [TMP_DIAG_ID],
        @diagnosis AS [TMP_DIAGNOSIS],
        [A].[attend_hcp_id] AS [TMP_DR_ID],
        [A].[status_cd] AS [TMP_ENC_STATUS_CD],
        [B].[last_nm] AS [TMP_DR_LAST_NAME],
        [B].[first_nm] AS [TMP_DR_FIRST_NAME],
        [B].[middle_nm] AS [TMP_DR_MIDDLE_NAME],
        [C].[status_cd] AS [TMP_ENC_MAP_STATUS_CD],
        [C].[event_cd] AS [TMP_STAT_ACT_CODE],
        [A].[vip_sw] AS [TMP_VIP_SW],
        SPACE(20) AS [TMP_DEPT_CODE],
        [A].[unit_org_id] AS [TMP_DEPT_ID],
        [A].[rm] AS [TMP_ROOM],
        [A].[bed] AS [TMP_BED],
        [A].[discharge_dispo_cid] AS [TMP_DISPO_CID]
    INTO
        [dbo].[#ENCOUNTERS]
    FROM
        [dbo].[int_encounter] AS [A]
        INNER JOIN [dbo].[int_encounter_map] AS [C] ON [A].[encounter_id] = [C].[encounter_id]
        LEFT OUTER JOIN [dbo].[int_hcp] AS [B] ON [A].[attend_hcp_id] = [B].[hcp_id]
    WHERE
        @patient_id = [C].[patient_id]
        AND [C].[status_cd] IN (N'N', N'S', N'C')
        AND ([A].[status_cd] != N'X'
        OR [A].[status_cd] IS NULL
        ); /* filter canceled encounters */

    UPDATE
        [dbo].[#ENCOUNTERS]
    SET
        [TMP_DIAGNOSIS] = ISNULL([dsc], N' '),
        [TMP_DIAG_ID] = ISNULL([diagnosis_cid], 0)
    FROM
        [dbo].[#ENCOUNTERS] AS [A]
        INNER JOIN [dbo].[int_diagnosis] AS [B] ON [A].[TMP_ENC_ID] = [B].[encounter_id]
    WHERE
        [B].[inactive_sw] IS NULL
        AND [B].[seq_no] = (SELECT
                                MAX([B].[seq_no])
                            FROM
                                [dbo].[#ENCOUNTERS] AS [A]
                                INNER JOIN [dbo].[int_diagnosis] AS [B] ON [A].[TMP_ENC_ID] = [B].[encounter_id]
                            WHERE
                                [B].[inactive_sw] IS NULL
                           );

    -- Update each of the records in the temporary table that have an account number and have not been moved or merged
    UPDATE
        [dbo].[#ENCOUNTERS]
    SET
        [TMP_ACCT_XID] = [ia].[account_xid]
    FROM
        [dbo].[#ENCOUNTERS]
        INNER JOIN [dbo].[int_encounter] AS [ie] ON [#ENCOUNTERS].[TMP_ENC_ID] = [ie].[encounter_id]
        INNER JOIN [dbo].[int_account] AS [ia] ON [ie].[account_id] = [ia].[account_id]
    WHERE
        [ie].[patient_id] = @patient_id
        AND [ia].[account_xid] IS NOT NULL
        AND [#ENCOUNTERS].[TMP_ENC_MAP_STATUS_CD] != N'N';

    -- Update each of the records in the temporary table that do not have an account number and have not been moved or merged
    UPDATE
        [dbo].[#ENCOUNTERS]
    SET
        [TMP_ACCT_XID] = @strNotAvail
    FROM
        [dbo].[#ENCOUNTERS]
    WHERE
        [#ENCOUNTERS].[TMP_ACCT_XID] = @acct_no /* SEE DETAIL */
        AND [#ENCOUNTERS].[TMP_ENC_MAP_STATUS_CD] != N'N'
        AND [#ENCOUNTERS].[TMP_ENC_MAP_STATUS_CD] != N'S';

    UPDATE
        [dbo].[#ENCOUNTERS]
    SET
        [TMP_DIAGNOSIS] = [imc].[short_dsc]
    FROM
        [dbo].[#ENCOUNTERS]
        INNER JOIN [dbo].[int_misc_code] AS [imc] ON [#ENCOUNTERS].[TMP_DIAG_ID] = [imc].[code_id]
    WHERE
        [#ENCOUNTERS].[TMP_DIAG_ID] != 0;

    -- Retrieve patient class and type from misc_code; short_dsc is NULL
    UPDATE
        [dbo].[#ENCOUNTERS]
    SET
        [TMP_PAT_TYPE] = ISNULL([M].[short_dsc], N''),
        [TMP_PAT_CLASS] = ISNULL([M2].[short_dsc], N'')
    FROM
        [dbo].[#ENCOUNTERS]
        LEFT OUTER JOIN [dbo].[int_misc_code] AS [M] ON [#ENCOUNTERS].[TMP_PAT_TYPE_ID] = [M].[code_id]
        INNER JOIN [dbo].[int_misc_code] AS [M2] ON [#ENCOUNTERS].[TMP_PAT_CLASS_ID] = [M2].[code_id];

    -- Retrieve medical service from misc_code; ignore if short_dsc is NULL
    UPDATE
        [dbo].[#ENCOUNTERS]
    SET
        [TMP_MED_SRVC] = [imc].[short_dsc]
    FROM
        [dbo].[#ENCOUNTERS]
        INNER JOIN [dbo].[int_misc_code] AS [imc] ON [#ENCOUNTERS].[TMP_MED_SRVC_ID] = [imc].[code_id]
    WHERE
        [imc].[short_dsc] IS NOT NULL;

    UPDATE
        [dbo].[#ENCOUNTERS]
    SET
        [TMP_DEPT_CODE] = [io].[organization_cd]
    FROM
        [dbo].[int_organization] AS [io]
    WHERE
        [TMP_DEPT_ID] = [io].[organization_id];

    -- Data has been built now select out all data
    SELECT
        [e].[TMP_ACCT_XID],
        [e].[TMP_ENC_ID],
        [e].[TMP_ACCT_ID],
        [e].[TMP_PAT_TYPE],
        [e].[TMP_ADMIT_DT],
        [e].[TMP_DISCH_DT],
        [e].[TMP_MED_SRVC],
        [e].[TMP_DIAGNOSIS],
        [e].[TMP_ENC_STATUS_CD],
        [e].[TMP_DR_ID],
        [e].[TMP_DR_LAST_NAME],
        [e].[TMP_DR_FIRST_NAME],
        [e].[TMP_DR_MIDDLE_NAME],
        [e].[TMP_ENC_MAP_STATUS_CD],
        [e].[TMP_ENC_XID],
        [e].[TMP_STAT_ACT_CODE],
        [e].[TMP_PAT_CLASS],
        [e].[TMP_VIP_SW],
        [e].[TMP_DEPT_CODE],
        [e].[TMP_DEPT_ID],
        [e].[TMP_ROOM],
        [e].[TMP_BED],
        [e].[TMP_DISPO_CID]
    FROM
        [dbo].[#ENCOUNTERS] AS [e]
    ORDER BY
        [e].[TMP_ADMIT_DT] DESC;

    DROP TABLE [dbo].[#ENCOUNTERS];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Encounters_Detail';

